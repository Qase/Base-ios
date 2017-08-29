//
//  BaseTableViewController.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 03/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import UIKit

/// Dismissable protocol is for option of hide view controllers on demand thus we need save reference
public protocol Dismissable {
    var controlerToDismiss: UIViewController? {get set}
}

open class QBaseTableViewController: QBaseViewController, UITableViewDelegate {

    public let tableView = UITableView()

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive=true
        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive=true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: QConstants.TableCells.defaultCell)
        tableView.dataSource = self
        tableView.delegate = self

        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.tableFooterView = UIView()
    }
}

// MARK: - Table view data source
extension QBaseTableViewController : UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QConstants.TableCells.defaultCell, for: indexPath)
        return cell
    }
}

extension QBaseTableViewController {
    open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if var _self = self as? Dismissable {
            _self.controlerToDismiss = viewControllerToPresent
        }
        super.present(viewControllerToPresent, animated:flag, completion: completion)
    }
}
