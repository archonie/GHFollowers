//
//  TabBarViewController.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 6.12.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchNC = UINavigationController(rootViewController: SearchVC())
        let favoritesNC = UINavigationController(rootViewController: FavoritesListVC())
        
        searchNC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favoritesNC.tabBarItem.image = UIImage(systemName: "star")
        
        searchNC.tabBarItem.title = "Search"
        favoritesNC.tabBarItem.title = "Favorites"
        
        tabBar.tintColor = .systemGreen
        
        setViewControllers([searchNC, favoritesNC], animated: true)
        
    }
    


}
