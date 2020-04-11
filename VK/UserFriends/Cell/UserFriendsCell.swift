//
//  UserFriendsCell.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

protocol FriendsCellViewModel {
    var name: String { get }
    var iconUrlString: String { get }
}

class UserFriendsCell: UITableViewCell {
    
    static let reuseId = "UserFriendsCell"
    var iconImageView = WebImageView()
    var friendNameLabel = UILabel()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
}
