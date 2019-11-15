//
//  SignInViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    let mainButton: GradientButton = {
        let button = GradientButton.system(with: "Sign in")
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buttonLayout()
        title = "Sign in"
    }

    @objc
    func myButtonTapped() {
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .fullScreen
        present(AuthorizationVC(), animated: true, completion: nil)
    }
}

extension SignInViewController {
    private func buttonLayout() {
        view.addSubview(mainButton)
        mainButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}