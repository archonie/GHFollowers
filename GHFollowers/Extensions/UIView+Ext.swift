//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 13.12.2024.
//


import UIKit

extension UIView {
    
    // Variadic parameter -> Translates the parameters to an array
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
