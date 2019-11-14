//
//  SplashViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var gameTimer : Timer?
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel.text = "Добро\nпожаловать"
        return textLabel
    }()

    private let beginButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buttonLayout()
        labelLayout()
        beginButton.animateGradient()
		gameTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {[unowned self] _ in
			self.beginButton.animateGradient()
		})
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.gameTimer?.invalidate()
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

// MARK: - Layout
extension WelcomeViewController {
    private func labelLayout() {
        view.addSubview(textLabel)
        let margins = view.layoutMarginsGuide
        textLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: beginButton.topAnchor, constant: 10).isActive = true
    }

    private func buttonLayout() {
        view.addSubview(beginButton)
        beginButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        beginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        beginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        beginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}