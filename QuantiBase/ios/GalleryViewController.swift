//
//  GalleryViewController.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Photos
import SnapKit
import QuantiLogger

public class ScreenshotsGalleryViewController: UIViewController {
    private var closeBarButton = UIBarButtonItem(title: "close_button".localized, style: .plain, target: nil, action: nil)
    private let selectBarButton = UIBarButtonItem(title: "select".localized, style: .plain, target: nil, action: nil)
    private var collectionView: PanSelectableCollectionView!
    private let noScreenshotsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGrey
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "no_screenshots".localized
        label.textAlignment = .center
        return label
    }()
    private lazy var addedScreenshotsInfoPanel: AddedScreenshotsInfoPanel = {
        let addedScreenshotsInfoPanel = AddedScreenshotsInfoPanel()
        let readableUnit = UnitsConverter(bytes: Int64(originalArchiveSize)).getReadableUnit()
        let message = "size_of_added_screenshots".localizeWithFormat(arguments: readableUnit)
        addedScreenshotsInfoPanel.sizeOfScreenshots.text = message
        addedScreenshotsInfoPanel.countOfScreenshots.text = "number_of_added_screenshots".localizeWithFormat(arguments: "0")
        addedScreenshotsInfoPanel.isHidden = true
        return addedScreenshotsInfoPanel
    }()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let loadingState = BehaviorRelay<Bool>(value: false)
    private let originalArchiveSize: Int = {
        if let fileLogger: FileLogger = LogManager.shared.logger(),
            let archivedLogFilesSize = fileLogger.archivedLogFilesSize {
            return archivedLogFilesSize
        }
        return 0
    }()
    private let totalArchiveSize = BehaviorRelay<Int>(value: 0)
    private let screenshots = BehaviorRelay<[Screenshot]>(value: [])
    public let selectedScreenshotsSubject = PublishSubject<[Screenshot]>()
    private var galleryScreenshotsImages = BehaviorRelay<[UIImage]>(value: [])
    private lazy var galleryScreenshotsImagesObservable: Observable<[UIImage]> = {
        galleryScreenshotsImages.asObservable()
    }()

    private lazy var screenshotsItems: Observable<[GalleryScreenshots]> = {
        galleryScreenshotsImagesObservable
            .flatMap { screenshots -> Observable<[Screenshot]> in
                Observable.combineLatest(
                    screenshots.map { image -> Observable<Screenshot> in
                        var imageData = image.pngData()
                        let uploadKeyName = image.accessibilityIdentifier
                        let uploadFileURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + ((uploadKeyName ?? String.random()) + ".png"))
                        if FileManager.default.fileExists(atPath: uploadFileURL.absoluteString) {
                            do {
                                try FileManager.default.removeItem(at: uploadFileURL)
                            } catch {
                                QLog("Error deleting file for screenshot", onLevel: .error)
                            }
                        }
                        do {
                            try imageData?.write(to: uploadFileURL)
                        } catch {
                            QLog("Error rewriting file for screenshot", onLevel: .error)
                        }
                        return Observable.just(Screenshot(image: image, url: uploadFileURL))
                    }) { $0 }
            }
            .map { [weak self] items -> [GalleryScreenshots] in
                self?.screenshots.accept(items)
                self?.loadingState.accept(false)
                return [GalleryScreenshots(header: "gallery", items: items)]
            }
    }()

    private let bag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBinding()
        fetchGaleryScreenshots()
    }

    private func setupLayout() {
        title = "snapshot_gallery".localized
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = closeBarButton
        selectBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = selectBarButton
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 2
        collectionViewLayout.estimatedItemSize = CGSize(width: 50, height: 100)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: collectionViewLayout.minimumLineSpacing, left: 0, bottom: 0, right: 0)

        let collectionView = PanSelectableCollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.register(CallLogSnapshotCollectionViewCell.self, forCellWithReuseIdentifier: "CallLogSnapshotCollectionViewCell")

        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.maxSelectedItems = 5

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)
        }
        collectionView.delegate = self
        self.collectionView = collectionView

        view.addSubview(noScreenshotsLabel)
        noScreenshotsLabel.snp.makeConstraints { $0.edges.equalToSuperview() }

        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }

        view.addSubview(addedScreenshotsInfoPanel)
        addedScreenshotsInfoPanel.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.height.width.equalTo(120)
        }
    }

    private func setupBinding() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<GalleryScreenshots>(
            configureCell: { (_, collectionView, indexPath, screenshot) in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallLogSnapshotCollectionViewCell", for: indexPath) as? CallLogSnapshotCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.isSelected = false
                cell.snapshot = screenshot.image.resized(toSize: CGSize(width: 75, height: 150))
                cell.imageUrl = screenshot.url
                return cell
        })

        let selectedScreenshotsSize = collectionView.rx.selectedIndexPaths.asObservable()
            .compactMap { $0?.compactMap { [weak self] in
                self?.screenshots.value[$0.row] }
            }
            .map { screenshots -> Int in
                let totalSize = self.originalArchiveSize + screenshots
                    .compactMap { $0.url.fileSize }
                    .reduce(.zero, +)

                return totalSize
            }

        loadingState
            .asObservable()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: bag)

        loadingState
            .asObservable()
            .map { !$0 }
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: bag)

        closeBarButton.rx.tap
            .do(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .subscribe()
            .disposed(by: bag)

        screenshots
            .asObservable()
            .map { !$0.isEmpty }
            .bind(to: noScreenshotsLabel.rx.isHidden)
            .disposed(by: bag)

        screenshots
            .asObservable()
            .map { $0.isEmpty }
            .bind(to: addedScreenshotsInfoPanel.rx.isHidden)
            .disposed(by: bag)

        selectBarButton.rx.tap
            .do(onNext: { [weak self] in
                if let selectedScreenshots = self?.collectionView.indexPathsForSelectedItems?
                    .compactMap({ self?.screenshots.value[$0.row] }) {
                    self?.selectedScreenshotsSubject.onNext(selectedScreenshots)
                }
                self?.dismiss(animated: true, completion: nil)
            })
            .subscribe()
            .disposed(by: bag)

        collectionView.rx.selectedIndexPaths.asObservable()
            .map { $0?.count ?? 0 > 0 }
            .bind(to: selectBarButton.rx.isEnabled)
            .disposed(by: bag)

        selectedScreenshotsSize
            .map {
                let readableUnit = UnitsConverter(bytes: Int64($0)).getReadableUnit()
                return "size_of_added_screenshots".localizeWithFormat(arguments: readableUnit)
            }
            .bind(to: addedScreenshotsInfoPanel.sizeOfScreenshots.rx.text)
            .disposed(by: bag)

        selectedScreenshotsSize
            .bind(to: totalArchiveSize)
            .disposed(by: bag)

        collectionView.rx.selectedIndexPaths.asObservable()
            .compactMap {$0?.count}
            .map { "number_of_added_screenshots".localizeWithFormat(arguments: String($0)) }
            .bind(to: addedScreenshotsInfoPanel.countOfScreenshots.rx.text)
            .disposed(by: bag)

        screenshotsItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }

    private func fetchGaleryScreenshots() {
        loadingState.accept(true)
        noScreenshotsLabel.isHidden = true
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                guard fetchResult.count > 0 else {
                    return
                }

                let allGalleryScreenshots = fetchResult.objects(at: IndexSet(0...fetchResult.count - 1))
                    .filter { $0.mediaSubtypes == .photoScreenshot }
                    .compactMap { asset in
                        asset.getAssetThubnail()
                    }

                self.galleryScreenshotsImages.accept(allGalleryScreenshots)
            default:
                break
            }
        }
    }

    private func presentSizeError() {
        let alert = UIAlertController(title: nil,
                                      message: "error_archive_size".localizeWithFormat(arguments: "\(String(Constants.maxSizeOfArchive)) Mb"),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "close".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ScreenshotsGalleryViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let convertedScreenshotSize = screenshots.value[indexPath.row].url.fileSize else {
            return false
        }
        let doesTheSizeFit = UnitsConverter(bytes: Int64(convertedScreenshotSize + totalArchiveSize.value)).isLessThan(mB: Constants.maxSizeOfArchive)

        if !doesTheSizeFit {
            presentSizeError()
            return false
        }

        if let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count {
            return selectedItemsCount < Constants.maxNumberOfScreenshots
        }
        return true
    }
}
