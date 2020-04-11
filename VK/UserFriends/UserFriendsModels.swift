//
//  UserFriendsModels.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

enum UserFriends {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getUserFriends
                case getUser
                case revealFriendIds(friendId: Int)
            }
        }
        struct Response {
            enum ResponseType {
                case presentUserFriends(friend: FriendsResponse, revealedFriendIds: [Int])
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayUserFriends(friendsViewModel: FriendsViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var name: String
    var photoUrlString: String?
}

struct FriendsViewModel {
    struct Cell: FriendsCellViewModel {
        var friendId: Int
        
        var iconUrlString: String
        var name: String
    }
    let cells: [Cell]
}
