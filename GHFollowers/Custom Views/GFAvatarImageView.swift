//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 8.12.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = UIImage(named: "avatarPlaceholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = true
    }
    
}
