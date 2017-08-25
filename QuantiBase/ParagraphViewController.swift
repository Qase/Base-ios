//
//  ParagraphViewController.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//

import UIKit

open class ParagraphViewController: UIViewController {

    public let stackView = UIStackView()
    public let scrollView = UIScrollView()

    /// Enable or disable close button in view controller
    private let closeButtonView = UIView()

    public var shouldHideCloseButton: Bool = false {
        didSet {
            closeButtonView.isHidden = shouldHideCloseButton
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        //Padding
        let padding: CGFloat = 16

        //ScrollView
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        //Close button
        let closeButton = BaseButton()
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)

        let offset = CGFloat(15).scaled
        closeButton.contentEdgeInsets = UIEdgeInsets.init(top: offset, left: offset, bottom: offset, right: offset)

        closeButton.actionBlock = {(_) in
            self.dismiss(animated: true, completion: nil)
        }

        closeButtonView.addSubview(closeButton)

        closeButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
        }

        //Stackview
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = padding

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(padding)
            make.bottom.right.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().offset(-2*padding)
        }

        stackView.addArrangedSubview(closeButtonView)
    }

}
