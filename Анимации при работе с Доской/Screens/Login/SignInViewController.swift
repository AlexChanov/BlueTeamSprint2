//
//  SignInViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        view.backgroundColor = .white
        // button
        let myButton = UIButton.system(with: "Нажмите" + "\n" + "на кнопку")
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        myButton.titleLabel?.numberOfLines = 2
        myButton.center = view.center
        view.addSubview(myButton)
    }
    

    @objc
    private func myButtonTapped() {
        UserDefaults.standard.setIsLoggedIn(value: true)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }

}
