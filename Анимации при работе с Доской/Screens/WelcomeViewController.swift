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
    
    let startButton: GradientButton = {
        let button = GradientButton(type: .system)
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
		animationButton()
		gameTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {[unowned self] _ in
			self.animationButton()
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
    
    @objc
    private func animationButton(){
        self.startButton.gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
        self.startButton.gradientLayer.endPoint = CGPoint(x: 1, y: 0.0)
        let colors:[UIColor] = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        self.startButton.gradientLayer.colors = colors.map({ $0.cgColor })
        let locations: [NSNumber] = [1,1,1]
        self.startButton.gradientLayer.locations = locations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1, 1]
		gradientAnimation.duration = 2
        gradientAnimation.repeatCount = 1
        startButton.gradientLayer.add(gradientAnimation, forKey: nil)
	}
}
