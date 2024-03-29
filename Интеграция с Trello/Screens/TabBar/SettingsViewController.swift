//
//  SettingsViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SettingsViewController: SignInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        mainButton.setTitle("Sign out", for: .normal)
    }

    override func myButtonTapped() {
        TrelloManager.shared.deleteToken()
        UserDefaults.standard.deleteTrelloToken()
        // navigate to login screen
        AppDelegate.shared.rootViewController.switchToLogout()
    }
}
