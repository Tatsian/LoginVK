//
//  UserFriendsWorker.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class UserFriendsService {
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedFriendIds = [Int]()
    private var friendsResponse: FriendsResponse?
    private var newFromInProcess: String?

    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getUser(complition: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            complition(userResponse)
        }
    }
    
    func getFriends(complition: @escaping ([Int], FriendsResponse) -> Void) {
        fetcher.getFriends(nextBatchFrom: nil) { [weak self] (friends) in
            self?.friendsResponse = friends
            guard let friendsResponse = self?.friendsResponse else { return }
            complition(self!.revealedFriendIds, friendsResponse)
        }
    }
    
    func revealFriendIds(forFiendId friendId: Int, complition: @escaping ([Int], FriendsResponse) -> Void) {
        revealedFriendIds.append(friendId)
        guard let friendsResponse = self.friendsResponse else { return }
        complition(revealedFriendIds, friendsResponse)
    }
    
}
