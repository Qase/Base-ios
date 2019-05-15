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
    }

}
