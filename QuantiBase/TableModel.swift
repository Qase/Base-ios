//
//  TableModel.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 10/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import UIKit

public class TableRow {
    public var identifier: String?
    public var name = "RowName"
    public var hidden = false
    public var type: UITableViewCell.Type = UITableViewCell.self

    public init(identifier: String? = nil, name: String = "", type: UITableViewCell.Type = UITableViewCell.self) {
        self.identifier = identifier
        self.name = name
        self.type = type
    }
}

public class TableSection {
    public var identifier: String?
    public var name = ""
    public var rows: [TableRow] = []

    public init(identifier: String? = nil, name: String = "RowName") {
        self.identifier = identifier
        self.name = name
    }

    public func add(row: TableRow) {
        self.rows.append(row)
    }
}

public class CellRegister {
    public var cellType: UITableViewCell.Type = UITableViewCell.self
    public var cellIdentifier = ""

    public init(cellType: UITableViewCell.Type = UITableViewCell.self, cellIdentifier: String = "") {
        self.cellType = cellType
        self.cellIdentifier = cellIdentifier
    }
}

public class TableModel {
    public var sections: [TableSection] = []
    public var cells: [CellRegister] = []

    public init() {
    }

    public func rowForIndexPath(indexPath: IndexPath) -> TableRow? {
        return sections[indexPath.section].rows[indexPath.row]
    }

    public func registerCellsFor(tableView: UITableView) {
        for cell in cells {
            tableView.register(cell.cellType, forCellReuseIdentifier: cell.cellIdentifier)
        }
    }

    public func add(section: TableSection) {
        self.sections.append(section)
    }

    public var sectionCount: Int {
        return sections.count
    }

    public func cellIdentifierFor(indexPath: IndexPath) -> String {
        guard let type = self.rowForIndexPath(indexPath: indexPath)?.type else {
            return QConstants.TableCells.defaultCell
        }

        let ret = cells.first(where: { (cellReg) -> Bool in
            return cellReg.cellType == type
        })

        return ret?.cellIdentifier ?? QConstants.TableCells.defaultCell
    }

    public func cellFor(identifier: String) -> TableRow? {
        //TO-DO
//        let ret = sections[0].rows.first(where: { (cellReg) -> Bool in
//            return cellReg.identifier == identifier
//        })
//        return ret
        return nil
    }

    public func cellTypeFor(indexPath: IndexPath) -> UITableViewCell.Type {
        return self.rowForIndexPath(indexPath: indexPath)?.type ?? UITableViewCell.self
    }

    public func rowsIn(section: Int) -> Int {
        return self.sections[section].rows.count
    }

    public func titleForHeader(section: Int) -> String {
        return sections[section].name
    }
}
