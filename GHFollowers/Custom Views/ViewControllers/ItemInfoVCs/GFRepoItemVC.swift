//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.12.2024.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {

    weak var delegate: GFRepoItemVCDelegate?
    
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImage: SFSymbols.person!)
    }
    
    override func didTapActionButton() {
        delegate?.didTapGitHubProfile(for: user)
    }


}
