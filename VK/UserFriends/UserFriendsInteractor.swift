//
//  UserFriendsInteractor.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

protocol UserFriendsBusinessLogic {
    func makeRequest(request: UserFriends.Model.Request.RequestType)
}

class UserFriendsInteractor: UserFriendsBusinessLogic {

    typealias ResponseTypeAlias = UserFriends.Model.Response.ResponseType
    var presenter: UserFriendsPresentationLogic?
    var service: UserFriendsService?
    
    func makeRequest(request: UserFriends.Model.Request.RequestType) {
        if service == nil {
            service = UserFriendsService()
        }
        
        switch request {
        case .getUserFriends:
            service?.getFriends(complition: { [weak self] (revealedFriendIds, friends)  in
                self?.presenter?.presentData(response: ResponseTypeAlias.presentUserFriends(friend: friends, revealedFriendIds: revealedFriendIds))
            })
        case .getUser:
            service?.getUser(complition: {[weak self] (user) in
                self?.presenter?.presentData(response: ResponseTypeAlias.presentUserInfo(user: user))
            })
        case .revealFriendIds(let friendId):
            service?.revealFriendIds(forFiendId: friendId, complition: { [weak self] (revealedFriendIds, friend) in
                self?.presenter?.presentData(response: ResponseTypeAlias.presentUserFriends(friend: friend, revealedFriendIds: revealedFriendIds))
            })
        }
    }
}
