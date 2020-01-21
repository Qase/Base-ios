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
    case screenshotsGalleryViewController = "ScreenshotsGalleryViewController"
}

class MasterViewController: UIViewController {
	private let tableView = UITableView()

    let tableModel = TableModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
		tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive=true
		tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive=true

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableRow.defaultIdentifier)
		tableView.dataSource = self
		tableView.delegate = self

		automaticallyAdjustsScrollViewInsets = false
		tableView.tableFooterView = UIView()

		preapareTableModel()
    }

	private func preapareTableModel() {
		tableModel.cells.append(CellRegister(cellType: UITableViewCell.self, cellIdentifier: "Cell"))

		let viewControllersSection = TableSection(identifier: "viewControllers", name: "View Controllers")

		let webViewControllerRow = TableRow(identifier: RowsIdentifiers.webViewController.rawValue, type: UITableViewCell.self)
		let paragraphViewControllerRow = TableRow(identifier: RowsIdentifiers.paragraphViewController.rawValue, type: UITableViewCell.self)
        let garagraphViewControllerRow = TableRow(identifier: RowsIdentifiers.screenshotsGalleryViewController.rawValue, type: UITableViewCell.self)

		tableModel.add(section: viewControllersSection)

		viewControllersSection.add(row: webViewControllerRow)
		viewControllersSection.add(row: paragraphViewControllerRow)
        viewControllersSection.add(row: garagraphViewControllerRow)

        tableModel.registerCells(for: self.tableView)
	}

}

// MARK: - Table View datasource
extension MasterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableModel.sectionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.rows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableModel.cellIdentifier(on: indexPath), for: indexPath)

        let row = tableModel.row(on: indexPath)

        cell.textLabel?.text = row?.identifier

        return cell
    }
}

// MARK: - Table View delegate
extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let row = tableModel.row(on: indexPath)
        if let rowIdentifier = RowsIdentifiers(rawValue: (row?.identifier)!) {
            switch rowIdentifier {
            case .webViewController:
                presentWebViewController()
            case .paragraphViewController:
                presentParagraphViewController()
            case .screenshotsGalleryViewController:
                presentScreenshotGalleryViewController()
            }
        }
    }

    func presentWebViewController() {
        guard let _url = URL(string: Lorem.url) else { return }

//        present(UINavigationController(rootViewController: WebViewController(withURL: Lorem.URL)), animated: true)
        navigationController?.pushViewController(WebViewController(withURL: _url), animated: true)
    }

    func presentParagraphViewController() {
		let paragraphViewController = ParagraphViewController()

		let mainHeader = ParagrafLabel()
		mainHeader.font = UIFont.systemFont(ofSize: 21)
		mainHeader.text = Lorem.word

		paragraphViewController.stackView.addArrangedSubview(mainHeader)

		[ParagraphContent(header: Lorem.words(2), content: Lorem.words(100)),
		 ParagraphContent(header: Lorem.words(2), content: Lorem.words(100)),
		 ParagraphContent(header: Lorem.words(2), content: Lorem.words(100)),
		 ParagraphContent(header: Lorem.words(2), content: Lorem.words(100))].forEach { content in
			let section = ParagraphView(content)
			paragraphViewController.stackView.addArrangedSubview(section)
		}

        navigationController?.pushViewController(paragraphViewController, animated: true)

    }

    func presentScreenshotGalleryViewController() {
        let screenshotsGalleryViewController = ScreenshotsGalleryViewController()
        let screenshotsGalleryNavigationViewController = UINavigationController(rootViewController: screenshotsGalleryViewController)
        screenshotsGalleryNavigationViewController.modalPresentationStyle = .fullScreen
        present(screenshotsGalleryNavigationViewController, animated: true, completion: nil)
    }
}
