//
//  SignInViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нажмите \nна кнопку", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Регистрация"
        
        myButton.center = view.center
        view.addSubview(myButton)
    }
    

    @objc
    func myButtonTapped() {
        UserDefaults.standard.setIsLoggedIn(value: true)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }

}
