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
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
}
