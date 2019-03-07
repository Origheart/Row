//
//  Row.swift
//  51offer
//
//  Created by 51offer on 2018/4/2.
//  Copyright © 2018年 51offer. All rights reserved.
//

import UIKit

protocol Updatable: class {
    
    associatedtype ViewData
    
    func update(viewData: ViewData)
}

extension Updatable {
    func update(viewData: Any) {}
}

protocol RowType {
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    
    func update(cell: UITableViewCell)
    
    func cell<C: UITableViewCell>() -> C
    func cellItem<M>() -> M
}

class Row<Cell> where Cell: Updatable, Cell: UITableViewCell {
    
    let viewData: Cell.ViewData
    let reuseIdentifier = String(describing: Cell.self)
    let cellClass: AnyClass = Cell.self
    
    init(viewData: Cell.ViewData) {
        self.viewData = viewData
    }
    
    func cell<C: UITableViewCell>() -> C {
        guard let cell = _cell as? C else {
            fatalError("cell 类型错误")
        }
        return cell
    }
    
    func cellItem<M>() -> M {
        guard let cellItem = viewData as? M else {
            fatalError("cellItem 类型错误")
        }
        return cellItem
    }
    
    private var _cell: Cell?
    
    func update(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            self._cell = cell
            cell.update(viewData: viewData)
        }
    }
}

extension Row: RowType {}
