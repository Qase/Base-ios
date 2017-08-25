//
//  RoundedImageView.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 08/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import UIKit

open class RoundedImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
    }

}
