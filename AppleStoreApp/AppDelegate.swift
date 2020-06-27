//
//  AppDelegate.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 26/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = storyboard.instantiateInitialViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

