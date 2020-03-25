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
        return addedScreenshotsInfoPanel
    }()

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
    private var galleryScreenshotsAssets = BehaviorRelay<[PHAsset]>(value: [])
    private lazy var galleryScreenshotsAssetsObservable: Observable<[PHAsset]> = {
        galleryScreenshotsAssets.asObservable()
    }()

    private lazy var screenshotsItems: Observable<[GalleryScreenshots]> = {
        galleryScreenshotsAssetsObservable
            .flatMap { screenshots -> Observable<[Screenshot]> in
                Observable.combineLatest(
                    self.images.map { asset -> Observable<Screenshot> in
                        var imageData = asset.pngData()
//                        let data = asset.getAssetThubnail().jpegData(compressionQuality: 0.5)
                        let uploadKeyName = asset.accessibilityIdentifier
                        let uploadFileURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + (uploadKeyName ?? "123"))
                        if FileManager.default.fileExists(atPath: uploadFileURL.absoluteString) {
                            do {
                                try FileManager.default.removeItem(at: uploadFileURL)
                            } catch { }
                        }
                        do {
                            try imageData?.write(to: uploadFileURL)
                        } catch { }
                        return Observable.just(Screenshot(asset: asset, url: uploadFileURL))
                    }) { $0 }
            }
            .map { [weak self] items -> [GalleryScreenshots] in
                self?.screenshots.accept(items)
                return [GalleryScreenshots(header: "gallery", items: items)]
            }
    }()
    
    var images = [UIImage]()

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
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.delegate = self
        self.collectionView = collectionView

        view.addSubview(noScreenshotsLabel)
        noScreenshotsLabel.snp.makeConstraints { $0.edges.equalToSuperview() }

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
                cell.snapshot = screenshot.asset
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

        closeBarButton.rx.tap
            .do(onNext: { [weak self] in self?.dismiss(animated: true, completion: nil) })
            .subscribe()
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

        galleryScreenshotsAssetsObservable
            .map { !$0.isEmpty }
            .bind(to: noScreenshotsLabel.rx.isHidden)
            .disposed(by: bag)

        galleryScreenshotsAssetsObservable
            .map { ($0.isEmpty) }
            .bind(to: addedScreenshotsInfoPanel.rx.isHidden)
            .disposed(by: bag)

        screenshotsItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }

    private func fetchGaleryScreenshots() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let manager = PHImageManager.default
                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = false
                requestOptions.deliveryMode = .highQualityFormat
                
                let fetchOptions = PHFetchOptions()
                
                let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                if results.count > 0 {
                    for i in 0..<results.count {
                        let asset = results.object(at: i)
                        let size = CGSize(width: 75, height: 150)
                        manager().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                            if let image = image {
                                self.images.append(image)
                            } else {
                                print("error asset to image")
                            }
                        }
                    }
                }
                    
                let allGalleryPhotos: PHFetchResult<PHAsset>? = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                guard let photosCount = allGalleryPhotos?.count, photosCount > 0 else {
                    return
                }
                let screenshots = allGalleryPhotos?.objects(at: IndexSet(0...photosCount - 1))
                    .filter { $0.mediaSubtypes == .photoScreenshot }
                if let screenshots = screenshots {
                    self.galleryScreenshotsAssets.accept(screenshots)
                }
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
