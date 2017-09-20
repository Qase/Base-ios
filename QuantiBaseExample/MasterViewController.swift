//
//  MasterViewController.swift
//  QuantiBaseExample
//
//  Created by Jakub Prusa on 28.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import UIKit
import QuantiBase

enum RowsIdentifiers: String {
    case webViewController = "WebViewController"
    case paragraphViewController = "ParagraphViewController"
}

class MasterViewController: QBaseTableViewController {

    var tableModel = TableModel()

    override init() {
        super.init()
        
        preapareTableModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


    }

}

// MARK: - Table View datasource

extension MasterViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.rowsIn(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableModel.cellIdentifierFor(indexPath: indexPath), for: indexPath)

        let row = tableModel.rowForIndexPath(indexPath: indexPath)

        cell.textLabel?.text = row?.identifier

        return cell
    }
}

// MARK: - Table View delegate

extension MasterViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let row = tableModel.rowForIndexPath(indexPath: indexPath)
        if let rowIdentifier = RowsIdentifiers(rawValue: (row?.identifier)!) {
            switch rowIdentifier {
            case .webViewController:
                presentWebViewController()
            case .paragraphViewController:
                presentParagraphViewController()
            }
        }
    }

    func presentWebViewController() {
        guard let _url = URL(string: Lorem.url) else { return }

//        present(UINavigationController(rootViewController: WebViewController(withURL: Lorem.URL)), animated: true)
        navigationController?.pushViewController(WebViewController(withURL: _url), animated: true)
    }

    func presentParagraphViewController() {
        navigationController?.pushViewController(UIViewController(), animated: true)

    }
}



// MARK: - Table Model
extension MasterViewController {

    func preapareTableModel(){
        tableModel.cells.append(CellRegister(cellType: UITableViewCell.self, cellIdentifier: "Cell"))

        let viewControllersSection = TableSection(identifier: "viewControllers", name: "View Controllers")

        let webViewControllerRow = TableRow(identifier: RowsIdentifiers.webViewController.rawValue, type: UITableViewCell.self)
        let paragraphViewControllerRow = TableRow(identifier: RowsIdentifiers.paragraphViewController.rawValue, type: UITableViewCell.self)

        tableModel.add(section: viewControllersSection)

        viewControllersSection.add(row: webViewControllerRow)
        viewControllersSection.add(row: paragraphViewControllerRow)

        tableModel.registerCellsFor(tableView: self.tableView)

    }
}

