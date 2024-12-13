//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 13.12.2024.
//

import UIKit

// PROBABLY USE IT IN THE FUTURE
extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeAccessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
