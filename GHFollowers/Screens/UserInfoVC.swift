//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 9.12.2024.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        getUserInfo(for: username)
    }
    
    private func getUserInfo(for username: String) {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
