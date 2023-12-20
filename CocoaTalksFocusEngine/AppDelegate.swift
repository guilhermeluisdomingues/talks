//
//  AppDelegate.swift
//  CocoaTalksFocusEngine
//
//  Created by Guilherme Domingues on 14/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController: UIViewController = ViewController()
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }

}

