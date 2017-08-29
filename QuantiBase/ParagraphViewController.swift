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

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true


        //Close button
        let closeButton = BaseButton()
        closeButton.setImage(UIImage(named: "close", in: Bundle(for: QuantiBase.self), compatibleWith: nil), for: .normal)

        let offset = CGFloat(15).scaled
        closeButton.contentEdgeInsets = UIEdgeInsets.init(top: offset, left: offset, bottom: offset, right: offset)

        closeButton.actionBlock = {(_) in
            self.dismiss(animated: true, completion: nil)
        }

        closeButtonView.addSubview(closeButton)

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: closeButtonView.topAnchor, constant: padding).isActive=true
        closeButton.leftAnchor.constraint(equalTo: closeButtonView.leftAnchor, constant: padding).isActive=true
        closeButton.bottomAnchor.constraint(equalTo: closeButtonView.bottomAnchor, constant: -padding).isActive=true
        closeButton.rightAnchor.constraint(equalTo: closeButtonView.rightAnchor, constant: -padding).isActive=true

        //Stackview
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = padding

        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding).isActive=true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: padding).isActive=true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding).isActive=true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -padding).isActive=true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2*padding).isActive=true

        stackView.addArrangedSubview(closeButtonView)
    }

}
