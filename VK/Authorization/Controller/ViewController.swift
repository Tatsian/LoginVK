//
//  ViewController.swift
//  VK
//
//  Created by Tatsiana on 02.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vkImage = UIImageView()
    var loginTextField = UITextField()
    var passwordTextField = UITextField()
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#416794")
        createVKImage()
        setUp(textField: loginTextField, placeholder: "Enter login or email", isSecure: false)
        setUp(textField: passwordTextField, placeholder: "Enter password", isSecure: true)
        createAuthorizationButton()
        createConstraints()
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
    
    func setUp(textField: UITextField, placeholder: String, isSecure: Bool) {
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.placeholder = placeholder
        textField.center = self.view.center
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.isSecureTextEntry = isSecure
        self.view.addSubview(textField)
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
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -indent).isActive = true
        loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: heightOfField).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -indent).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -indent).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: heightOfField).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: indent).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -indent).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -width * 0.2).isActive = true
        button.heightAnchor.constraint(equalToConstant: heightOfField).isActive = true
    }
}

