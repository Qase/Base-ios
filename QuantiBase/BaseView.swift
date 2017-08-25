//
//  BasicView.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 03.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func setup() {
        preconditionFailure("This method must be overriden!")
    }

}
