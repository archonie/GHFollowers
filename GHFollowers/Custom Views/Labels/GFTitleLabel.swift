//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.12.2024.
//

import UIKit

class GFTitleLabel: UILabel {

    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat ) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
