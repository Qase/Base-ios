//
//  TableModel.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 10/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public class TableRow {
	public static let defaultIdentifier = "defaultCellIdentifier"
    public var identifier: String?
    public var name: String
    public var hidden = false
    public var type: UITableViewCell.Type
    public var size = 1

    public init(identifier: String? = nil, name: String = "rowName", type: UITableViewCell.Type = UITableViewCell.self) {
        self.identifier = identifier
        self.name = name
        self.type = type
    }
}

public class TableSection {
    public var identifier: String?
    public var name: String
    public var rows: [TableRow] = []

    public init(identifier: String? = nil, name: String = "sectionName") {
        self.identifier = identifier
        self.name = name
    }

    public func add(row: TableRow) {
        self.rows.append(row)
    }
}

public class CellRegister {
    public var cellType: UITableViewCell.Type
    public var cellIdentifier: String

    public init(cellType: UITableViewCell.Type = UITableViewCell.self, cellIdentifier: String = "cellIdentifier") {
        self.cellType = cellType
        self.cellIdentifier = cellIdentifier
    }
}

public class TableModel {
    public var sections: [TableSection] = []
    public var cells: [CellRegister] = []

    public init() {}

    public func registerCells(for tableView: UITableView) {
        cells.forEach { tableView.register($0.cellType, forCellReuseIdentifier: $0.cellIdentifier) }
    }

    public func add(section: TableSection) {
        sections.append(section)
    }

    public func remove(section: TableSection) {
        sections = sections.filter { $0 !== section }
    }

    public var sectionCount: Int {
        sections.count
    }

    public func titleForHeader(in section: Int) -> String {
        sections[section].name
    }

    public func rows(in section: Int) -> Int {
        sections[section].rows.reduce(0, { $0 + $1.size })
    }

    public func cell(with identifier: String) -> TableRow? {
        //TO-DO
        //        let ret = sections[0].rows.first(where: { (cellReg) -> Bool in
        //            return cellReg.identifier == identifier
        //        })
        //        return ret
        return nil
    }

    public func cellType(on indexPath: IndexPath) -> UITableViewCell.Type {
        self.row(on: indexPath)?.type ?? UITableViewCell.self
    }

    public func cellIdentifier(on indexPath: IndexPath) -> String {
        guard let type = self.row(on: indexPath)?.type else {
            return TableRow.defaultIdentifier
        }

		let ret = cells.first(where: { $0.cellType == type })

        return ret?.cellIdentifier ?? TableRow.defaultIdentifier
    }

    public func row(on indexPath: IndexPath) -> TableRow? {
        sections[indexPath.section].rows[absoluteRowIndex(on: indexPath)]
    }

    public func relativeRowIndex(on indexPath: IndexPath) -> Int {
        var rowIndex = 0
        for  element in sections[indexPath.section].rows {
            if (rowIndex + element.size) > indexPath.row && element.size != 0 {
                break
            }

            rowIndex += element.size
        }
        return indexPath.row - rowIndex
    }

    private func absoluteRowIndex(on indexPath: IndexPath) -> Int {
        var rowIndex = 0
        var ret = 0
        for (index, element) in sections[indexPath.section].rows.enumerated() {
            ret = index
            rowIndex += element.size
            if rowIndex > indexPath.row && element.size != 0 {
                break
            }

        }
        return ret
    }
}
#endif
