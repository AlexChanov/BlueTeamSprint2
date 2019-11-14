//
//  SplashViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class WelcomeViewController: SignInViewController {
    
    private var gameTimer : Timer?
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel.text = "Добро\nпожаловать"
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nil
        labelLayout()
        mainButton.animateGradient()
		gameTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {[unowned self] _ in
			self.mainButton.animateGradient()
		})
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.gameTimer?.invalidate()
	}
  
    override func myButtonTapped() {
        if UserDefaults.standard.isLoggedIn() {
            // navigate to main screen
            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
            // navigate to login screen
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }
}

// MARK: - Layout
extension WelcomeViewController {
    private func labelLayout() {
        view.addSubview(textLabel)
        let margins = view.layoutMarginsGuide
        textLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: 10).isActive = true
    }
}