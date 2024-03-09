//
//  UITableViewExt.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import UIKit

extension UITableView {
    func registerClass<C>(_ cellType: C.Type) where C: UITableViewCell {
        self.register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    func registerClassHeaderFooter<C>(_ cellType: C.Type) where C: UITableViewHeaderFooterView {
        self.register(cellType, forHeaderFooterViewReuseIdentifier: cellType.identifier)
    }
    
    func removeEmptyDataView() {
        self.backgroundView = nil
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
