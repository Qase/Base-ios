//
//  RoundedButton.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 09/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import UIKit

open class RoundedButton: BaseButton {

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
