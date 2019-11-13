//
//  SettingsViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // button
        let signOutButton = UIButton.system(with: "Sign out")
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        signOutButton.center = view.center
        view.addSubview(signOutButton)
        
    }
    
    @objc
    private func signOutButtonTapped() {
       UserDefaults.standard.setIsLoggedIn(value: false)
        // navigate to login screen
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
}
