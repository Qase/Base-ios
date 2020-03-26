//
//  CallLogSnapshotCollectionViewCell.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation
import SnapKit

public class CallLogSnapshotCollectionViewCell: UICollectionViewCell {
    private let snapshotImageView = UIImageView()
    
    public var snapshot: UIImage? {
        didSet {
            snapshotImageView.image = snapshot
        }
    }

    private let checkIcon = UIImageView(image: #imageLiteral(resourceName: "selected"))

    override public var isSelected: Bool {
        didSet {
            snapshotImageView.alpha = isSelected ? 0.6 : 1.0
            checkIcon.isHidden = !isSelected
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(snapshotImageView)
        snapshotImageView.snp.makeConstraints { $0.edges.equalToSuperview() }

        addSubview(checkIcon)
        checkIcon.isHidden = !isSelected

        checkIcon.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(32)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
