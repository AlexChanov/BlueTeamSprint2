//
//  SettingsViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.titleLabel?.text = "Sign Out"
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        signOutButton.center = view.center
        view.addSubview(signOutButton)
        
    }
    
    @objc
    func signOutButtonTapped() {
       UserDefaults.standard.setIsLoggedIn(value: false)
        
        
        // navigate to login screen
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    

   

}
