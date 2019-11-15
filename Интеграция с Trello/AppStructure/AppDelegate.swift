//
//  AppDelegate.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
		//
        TrelloManager.shared.initTask()
        return true
    }
}

extension AppDelegate {
    
    public static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    public var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
