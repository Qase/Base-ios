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
    private lazy var totalArchiveSize: BehaviorRelay<Int> = {
        let totalArchiveSize = BehaviorRelay<Int>(value: originalArchiveSize)
        return totalArchiveSize
    }()
    public let selectedScreenshotsSubject = PublishSubject<[URL]>()
    private var galleryScreenshotsAssets = BehaviorRelay<[PHAsset]>(value: [])
    private lazy var galleryScreenshotsAssetsObservable: Observable<[PHAsset]> = {
        galleryScreenshotsAssets.asObservable()
    }()

    private lazy var screenshotsItems: Observable<[GalleryScreenshots]> = {
        galleryScreenshotsAssetsObservable
            .map { assets in
                assets.map { Screenshot(asset: $0) }
            }
            .map { [weak self] items -> [GalleryScreenshots] in
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
                cell.snapshot = screenshot.asset.getAssetThubnail()
                    .resized(toSize: CGSize(width: 75, height: 150))
                return cell
        })
//        resized

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

        galleryScreenshotsAssets
            .asObservable()
            .map { !$0.isEmpty }
            .bind(to: noScreenshotsLabel.rx.isHidden)
            .disposed(by: bag)

        galleryScreenshotsAssets
            .asObservable()
            .map { $0.isEmpty }
            .bind(to: addedScreenshotsInfoPanel.rx.isHidden)
            .disposed(by: bag)

        selectBarButton.rx.tap
            .do(onNext: { [weak self] in
                if let selectedScreenshots = self?.collectionView.indexPathsForSelectedItems?
                    .compactMap({ self?.galleryScreenshotsAssets.value[$0.row] })
                    .map({ $0.url })
                    .compactMap({ $0 }) {
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

        totalArchiveSize
            .asObservable()
            .map {
                let readableUnit = UnitsConverter(bytes: Int64($0)).getReadableUnit()
                return "size_of_added_screenshots".localizeWithFormat(arguments: readableUnit)
            }
            .bind(to: addedScreenshotsInfoPanel.sizeOfScreenshots.rx.text)
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
                    .reversed()
                    .map { $0 }

                self.galleryScreenshotsAssets.accept(allGalleryScreenshots)
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
        guard let convertedScreenshotSize = galleryScreenshotsAssets.value[indexPath.row].size else {
            return false
        }
        let doesTheSizeFit = UnitsConverter(bytes: Int64(convertedScreenshotSize + totalArchiveSize.value)).isLessThan(mB: Constants.maxSizeOfArchive)

        if !doesTheSizeFit {
            presentSizeError()
            return false
        }

        if let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count,
            selectedItemsCount >= Constants.maxNumberOfScreenshots {
            return false
        }

        totalArchiveSize.accept(totalArchiveSize.value + convertedScreenshotSize)
        return true
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let convertedScreenshotSize = galleryScreenshotsAssets.value[indexPath.row].size else {
            return
        }
        totalArchiveSize.accept(totalArchiveSize.value - convertedScreenshotSize)
    }

}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage
}
