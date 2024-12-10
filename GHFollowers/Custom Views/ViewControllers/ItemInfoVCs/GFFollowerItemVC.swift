//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.12.2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func didTapActionButton() {
        delegate?.didTapGetFollowers(for: user)
    }
}
