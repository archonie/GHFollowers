//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 6.12.2024.
//

import UIKit

class SearchVC: UIViewController {
    
    private let logoImageView = UIImageView()
    
    private let usernameTextField = GFTextField()
    
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
    }
    
    // Will hide the navbar everytime the view appeared
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "ghLogo")
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
 

}
