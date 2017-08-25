//
//  BasicViewController.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 03.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

open class QBaseViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
