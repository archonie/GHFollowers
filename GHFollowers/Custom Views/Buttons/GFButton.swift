//
//  GFButton.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 6.12.2024.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemImage: UIImage) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImage: systemImage)
    }
    
    private func configure() {
        if traitCollection.userInterfaceStyle == .dark {
            configuration = .tinted()
        } else {
            configuration = .filled()
        }
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, systemImage: UIImage) {
        if traitCollection.userInterfaceStyle == .dark {
            // Dark mode styling
            configuration?.background.strokeColor = color
            configuration?.baseBackgroundColor = color
            configuration?.baseForegroundColor = color
        } else {
            // Light mode styling
            configuration?.background.strokeColor = nil
            configuration?.baseBackgroundColor = color
            configuration?.baseForegroundColor = .white
        }
        
        configuration?.title = title
        configuration?.image = systemImage
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
    
}
