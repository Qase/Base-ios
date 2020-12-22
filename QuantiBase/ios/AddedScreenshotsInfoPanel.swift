//
//  AddedScreenshotsInfoPanel.swift
//  QuantiBase
//
//  Created by George Ivannikov on 2/24/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

#if canImport(UIKit)

import UIKit

class AddedScreenshotsInfoPanel: UIView {
    var countOfScreenshots: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        return label
    }()

    var countOfScreenshotsMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "\("max".localizeWithFormat(arguments: "5"))"
        label.textAlignment = .center
        return label
    }()

    var sizeOfScreenshots: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        return label
    }()

    var sizeOfScreenshotsMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "\("max".localizeWithFormat(arguments: "10 Mb"))"
        label.textAlignment = .center
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    func setupView() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10.0

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }

        [sizeOfScreenshots,
         sizeOfScreenshotsMessage,
         countOfScreenshots,
         countOfScreenshotsMessage].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }
        }
    }
}
#endif
