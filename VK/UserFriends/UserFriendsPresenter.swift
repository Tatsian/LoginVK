//
//  UserFriendsPresenter.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

protocol UserFriendsPresentationLogic {
    func presentData(response: UserFriends.Model.Response.ResponseType)
}

class UserFriendsPresenter: UserFriendsPresentationLogic {
    
    typealias ViewModelAlias = UserFriends.Model.ViewModel.ViewModelData
    weak var viewController: UserFriendsDisplayLogic?
    
    func presentData(response: UserFriends.Model.Response.ResponseType) {
        switch response {
        case .presentUserFriends(let friend, let revealedFriendIds):
            let cells = friend.items.map { (friendItem) in
                cellViewModel(from: friendItem,
                              profiles: friend.profiles,
                              revealedFriendIds: revealedFriendIds)
            }
            let friendViewModel = FriendsViewModel.init(cells: cells)
            viewController?.displayData(viewModel: ViewModelAlias.displayUserFriends(friendsViewModel: friendViewModel))
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(name: user!.name, photoUrlString: user!.photo100)
            viewController?.displayData(viewModel: ViewModelAlias.displayUser(userViewModel: userViewModel))
        }
    }
    
    private func cellViewModel(from friendItem: FriendsItems,
                               profiles: [Profile],
                               revealedFriendIds: [Int]) -> FriendsViewModel.Cell {
        let profile = self.profile(for: friendItem.friendId, profiles: profiles)
        return FriendsViewModel.Cell.init(friendId: friendItem.friendId,
                                       iconUrlString: profile.photo,
                                       name: profile.name)
    }
    
    private func profile(for sourseId: Int, profiles: [Profile]) -> ProfileRepresentable {
        let profiles: [ProfileRepresentable] = profiles
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profiles.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
}
