//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 8.12.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let cache = NetworkManager.shared.cache
    
    private let placeholderImage = Images.avatarPlaceholder
    
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
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func downloadImage(from url: String) {
        
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
        
//        NetworkManager.shared.downloadImage(from: url) {[weak self] image in
//            guard let self = self else { return }
//            guard let image = image else { return }
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }
    }
}
