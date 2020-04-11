//
//  UserFriendsCodeCell.swift
//  VK
//
//  Created by Tatsiana on 10.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

protocol UserFriendsCodeCellDelegate: class {
    func revealFriend(for cell: UserFriendsCodeCell)
}

final class UserFriendsCodeCell: UITableViewCell {
    static let reuseId = "UserFriendsCodeCell"
    weak var delegate: UserFriendsCodeCellDelegate?
    
    let topView = UIView()
    let iconImageView = WebImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#000000")
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewModel: FriendsCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        
        let minSide = min(topView.frame.size.width, topView.frame.size.height)
        let width = minSide / 4
        let indent: CGFloat = 8
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: width).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: indent).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
