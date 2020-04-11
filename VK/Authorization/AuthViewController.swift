//
//  ViewController.swift
//  VK
//
//  Created by Tatsiana on 02.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    var vkImage = UIImageView()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#416794")
        createVKImage()
        createAuthorizationButton()
        createConstraints()
        
        authService = AppDelegate.shared().authService
        self.navigationController?.isNavigationBarHidden = true
    }

    func createVKImage() {
        let image = UIImage(named: "vkImage")
        vkImage = UIImageView(image: image)
        vkImage.transform = .init(translationX: 0, y: -100)
        UIView.animate(withDuration: 0.5, animations: {
            self.vkImage.transform = .identity
        })
        self.view.addSubview(vkImage)
    }
    
    func createAuthorizationButton() {
        button = UIButton(type: .system)
        button.backgroundColor = UIColor(hex: "#324F72")
        button.layer.cornerRadius = 8
        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(pressAuthorizationButton), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func pressAuthorizationButton(_ sender: UIButton!) {
        print("Hello world")
        authService.wakeUpSession()
    }
    
    func createConstraints() {
        let minSide = min(view.frame.size.width, view.frame.size.height)
        let width = minSide / 2
        let heightOfField: CGFloat = 40
        let indent: CGFloat = 20

        vkImage.translatesAutoresizingMaskIntoConstraints = false
        vkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: width * 0.1).isActive = true
        vkImage.centerXAnchor.constraint(
          equalTo: view.centerXAnchor).isActive = true
        vkImage.heightAnchor.constraint(equalToConstant: width).isActive = true
        vkImage.widthAnchor.constraint(equalToConstant: width).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -indent).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: heightOfField).isActive = true
    }
}
