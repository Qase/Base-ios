//
//  ParagrafView.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//
#if canImport(UIKit)

import UIKit

public struct ParagraphContent {
    public let header: String
    public let content: String

    public init(header: String, content: String) {
        self.header = header
        self.content = content
    }
}

open class ParagraphView: UIView {

    public let headerLabel = ParagrafLabel()
    public let contentLabel = ParagrafLabel()

    public init(_ paragraph: ParagraphContent) {
        super.init(frame: CGRect.zero)

        self.headerLabel.text = paragraph.header
        self.contentLabel.text = paragraph.content

		contentLabel.textColor = UIColor(red: 164/255.0, green: 164/255.0, blue: 167/255.0, alpha: 1) // Gray color
		contentLabel.font = UIFont.systemFont(ofSize: 10)

		self.addSubview(headerLabel)

		headerLabel.translatesAutoresizingMaskIntoConstraints = false
		headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive=true
		headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive=true
		headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive=true

		self.addSubview(contentLabel)

		contentLabel.translatesAutoresizingMaskIntoConstraints = false
		contentLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8).isActive=true
		contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive=true
		contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive=true
		contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
