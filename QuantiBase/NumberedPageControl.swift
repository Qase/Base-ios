//
//  NumberedPageControl.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 16/04/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import UIKit

public class NumberedPageControl: UIControl {
	private let label = UILabel()

	public var numberOfPages: Int = 0 {
		didSet {
			guard numberOfPages >= 1 else {
				assertionFailure("numberOfPages cannot be set to 0 or to a negative number.")
				return
			}

			refreshLabel()
		}
	}

	public var currentPage: Int = 0 {
		didSet {
			guard currentPage >= 0 else {
				assertionFailure("currentPage cannot be set to a negative number.")
				return
			}

			refreshLabel()
		}
	}

	public var hidesForSinglePage: Bool = false {
		didSet {
			refreshLabel()
		}
	}

	public var textSize: CGFloat = 10.0 {
		didSet {
			label.font = label.font.withSize(textSize)
		}
	}

	public var textColor: UIColor = .black {
		didSet {
			label.textColor = textColor
		}
	}

	public var color: UIColor = .clear {
		didSet {
			backgroundColor = color.withAlphaComponent(0.6)
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		layer.cornerRadius = 10.0
		clipsToBounds = true

		label.font = UIFont.boldSystemFont(ofSize: 10.0)

		addSubview(label)

		label.translatesAutoresizingMaskIntoConstraints = false
		label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
		label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
		label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
		label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true

		refreshLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func refreshLabel() {
		isHidden = (hidesForSinglePage && numberOfPages == 1) ? true : false
		label.text = "\(currentPage+1)/\(numberOfPages)"
	}
}
