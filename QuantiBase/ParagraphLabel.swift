//
//  ParagrafLabel.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

open class ParagrafLabel: UILabel {
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    open func setup() {
        self.numberOfLines = 0
        self.textAlignment = .justified
    }
}
