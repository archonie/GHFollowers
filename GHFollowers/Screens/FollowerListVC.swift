//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.12.2024.
//

import UIKit



class FollowerListVC: GFDataLoadingVC {
    
    enum Section {
        case main
    }

    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    private var username = ""
    private var page: Int = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    private var isLoadingMoreFollowers = false
    
    private var collectionView: UICollectionView!
    private var dataSoure: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func getFollowers(username: String, page: Int) {
        isLoadingMoreFollowers = true
        showLoadingView()
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                isLoadingMoreFollowers = false
                dismissLoadingView()
                self.updateUI(with: followers)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                isLoadingMoreFollowers = false
                dismissLoadingView()
            }
        }

//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            
//            guard let self = self else {
//                return
//            }
//            self.dismissLoadingView()
//            
//            switch result {
//            case .success(let followers):
//                self.updateUI(with: followers)
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
//            }
//            self.isLoadingMoreFollowers = false
//        }
    }
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 {
            self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😉."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }
        self.updateData(on: self.followers)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureDataSource() {
        dataSoure = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSoure.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    @objc private func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                dismissLoadingView()
                addUserToFavorites(user: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                dismissLoadingView()
            }
            
//            guard let followers = try? await NetworkManager.shared.getFollowers(for: username, page: page) else {
//                presentDefaultAlert()
//                return
//            }
//            updateUI(with: followers)
        }
        
//        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
//            guard let self = self else {
//                return
//            }
//            self.dismissLoadingView()
//            switch result {
//            case .success(let user):
//                self.addUserToFavorites(user: user)
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
//            }
//        }
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self else {
                return
            }
            guard let error else {
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Success!", message: "You have successfully favorited this user!", buttonTitle: "Ok")
                }
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else {
                return
            }
            page += 1
            getFollowers(username: username, page: page )
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased())})
        updateData(on: filteredFollowers)
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        
        filteredFollowers.removeAll()
        followers.removeAll()
        hasMoreFollowers = true
        isSearching = false
        collectionView.setContentOffset(CGPoint(x: 0, y: -view.safeAreaInsets.top), animated: true)
        //collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true) might need later
        getFollowers(username: username, page: page)
    }
}
