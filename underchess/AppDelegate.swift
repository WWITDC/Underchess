//
//  AppDelegate.swift
//  underchess
//
//  Created by Apollonian on 16/2/13.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .tianyiBlue
        window?.rootViewController = UCSplashViewController()
        window?.makeKeyAndVisible()
        application.isStatusBarHidden = true
        return true
    }


}

