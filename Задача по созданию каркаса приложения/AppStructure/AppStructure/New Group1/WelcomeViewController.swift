//
//  SplashViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let attributedText = NSMutableAttributedString(string: "Добро", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\nпожаловать!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        welcomeTextView.center = view.center
        view.addSubview(welcomeTextView)
        
        startButton.center = view.center
        view.addSubview(startButton)
    }
    
    @objc
    func startButtonTapped() {
        if UserDefaults.standard.isLoggedIn() {
            // navigate to main screen
            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
            // navigate to login screen
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }
    
}
