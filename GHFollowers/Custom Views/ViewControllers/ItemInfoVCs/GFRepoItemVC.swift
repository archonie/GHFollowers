//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.12.2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func didTapActionButton() {
        delegate?.didTapGitHubProfile(for: user)
    }


}
