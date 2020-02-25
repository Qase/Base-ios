//
//  AddedScreenshotsInfoPanel.swift
//  QuantiBase
//
//  Created by George Ivannikov on 2/24/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import UIKit

class AddedScreenshotsInfoPanel: UIView {
    var countOfScreenshots: UILabel = {
        let label = UILabel()
        label.text = "Number of added screnshots: 0 (max. 5)"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    var sizeOfScreenshots: UILabel = {
        let label = UILabel()
        label.text = "Size of added screnshots: 0 b (max. 10 Mb)"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0
        return stackView
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
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        [sizeOfScreenshots, countOfScreenshots].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }
        }
    }
}
