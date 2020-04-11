//
//  AppDelegate.swift
//  VK
//
//  Created by Tatsiana on 02.04.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        self.authService = AuthService()
        
        authService.delegate = self as? AuthServiceDelegate
        let scope = ["wall", "friends"]
        
        VKSdk.wakeUpSession(scope) { (state, _) in
            if state == VKAuthorizationState.authorized {
                self.authServiceSingIn()
            } else {
                self.authVC()
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        VKSdk.processOpen(url as URL, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
       return true
    }

    func authServiceSingIn() {
        print(#function)
        let friendsVC = UserFriendsViewController()
        let navVC = UINavigationController(rootViewController: friendsVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func authServiceDidSingInFail() {
        print(#function)
    }
    
    func authVC() {
        print(#function)
        let authVC = AuthViewController()
        let navVC = UINavigationController(rootViewController: authVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

}

