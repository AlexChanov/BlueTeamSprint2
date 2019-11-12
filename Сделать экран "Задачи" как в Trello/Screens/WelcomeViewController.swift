//
//  WelcomViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // title
        let welcomeTextView = UITextView.system(with: "Добро" + "\n" + "пожаловать!")
        welcomeTextView.center = view.center
        view.addSubview(welcomeTextView)
        // button
        let startButton = UIButton.system(with: "Начать")
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.center = view.center
        view.addSubview(startButton)
    }
    
    
    @objc
    private func startButtonTapped() {
        if UserDefaults.standard.isLoggedIn() {
            // navigate to main screen
            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
            // navigate to login screen
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }
    
}
