//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 11.12.2024.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        
        self.viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = tabbar.tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabbar.tabBar.insertSubview(blurView, at: 0)
        
        return tabbar
    }

}
