//
//  UserFriendsViewController.swift
//  VK
//
//  Created by Tatsiana on 07.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

protocol UserFriendsDisplayLogic: class {
    func  displayData(viewModel: UserFriends.Model.ViewModel.ViewModelData)
}

class UserFriendsViewController: UIViewController, UserFriendsDisplayLogic, UserFriendsCodeCellDelegate, TitleViewDelegate {
    
    var interactor: UserFriendsBusinessLogic?
    var router: (NSObjectProtocol & UserFriendsRoutingLogic)?
    
    private var friendsViewModel = FriendsViewModel.init(cells: [])
    
    var tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    private lazy var titleView = TitleView()
    
//    private var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return refreshControl
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setUp()
        setupTopBars()
        
        interactor?.makeRequest(request: UserFriends.Model.Request.RequestType.getUserFriends)
        interactor?.makeRequest(request: UserFriends.Model.Request.RequestType.getUser)
        // Do any additional setup after loading the view.
    }
    
    private func setUp() {
        let viewController = self
        let interactor = UserFriendsInteractor()
        let presenter = UserFriendsPresenter()
        let router = UserFriendsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func setupTopBars() {
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = .blue
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView

        titleView.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        //      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserFriendsCell ")
    }
    //    @objc private func refresh() {
//         addFeedBack()
//         interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsfeed)
//     }
    
    func displayData(viewModel: UserFriends.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayUserFriends(let friendsViewModel):
            self.friendsViewModel = friendsViewModel
            tableView.reloadData()
        case .displayUser(let userViewModel):
            titleView.set(userViewModel: userViewModel)
        }
    }
    
    func revealFriend(for cell: UserFriendsCodeCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellViewModel = friendsViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: UserFriends.Model.Request.RequestType.revealFriendIds(friendId: cellViewModel.friendId))
    }
    
    func buttonLogOutSession(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFriendsCodeCell.reuseId, for: indexPath) as! UserFriendsCodeCell
        let cellViewModel = friendsViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
}
