//
//  TitleView.swift
//  VK
//
//  Created by Tatsiana on 08.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol TitleViewDelegate: class {
    func buttonLogOutSession(sender: UIButton)
    }

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
    var name: String { get }
}

class TitleView: UIView {
    
    weak var delegate: TitleViewDelegate?
    
    private var buttonLogOutSession: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hex: "324872")
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return button
    }()
    
    private var myName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "FFFFFF")
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(hex: "FF9500")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonLogOutSession.addTarget(self, action: #selector(buttonLogOut), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonLogOutSession)
        addSubview(myName)
        addSubview(myAvatarView)
        createConstraints()
    }
    
    @objc func buttonLogOut(sender: UIButton) {
        print(#function)
        delegate?.buttonLogOutSession(sender: sender)
    }
    
    //MARK: set data
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
        myName.text = userViewModel.name
    }
    
    //MARK: create constraints
    private func createConstraints() {
        let minSide = min(superview!.frame.size.width, superview!.frame.size.height)
        let width = minSide / 4
        let indent: CGFloat = 8
        
        buttonLogOutSession.translatesAutoresizingMaskIntoConstraints = false
        buttonLogOutSession.topAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.topAnchor)!, constant: indent).isActive = true
        buttonLogOutSession.heightAnchor.constraint(equalToConstant: width).isActive = true
        buttonLogOutSession.widthAnchor.constraint(equalToConstant: width).isActive = true
        buttonLogOutSession.leadingAnchor.constraint(equalTo: myName.trailingAnchor, constant: indent).isActive = true
        buttonLogOutSession.trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -indent).isActive = true
        
        myName.translatesAutoresizingMaskIntoConstraints = false
        myName.topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        myName.heightAnchor.constraint(equalToConstant: width).isActive = true
        myName.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        
        myAvatarView.translatesAutoresizingMaskIntoConstraints = false
        myAvatarView.topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: indent).isActive = true
        myAvatarView.heightAnchor.constraint(equalToConstant: width).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: myName.leadingAnchor, constant: indent).isActive = true
        myAvatarView.leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        myAvatarView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
