//
//  LoginViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Login"))
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // navBar
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // image
        view.addSubview(bearImageView)
        // signIn button
        let signInButton = UIButton.system(with: "Sign in")
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInButton.frame.origin = CGPoint(x: 100, y: 300)
        view.addSubview(signInButton)
        // signUp button
        let signUpButton = UIButton.system(with: "Sign up")
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signUpButton.frame.origin = CGPoint(x: 100, y: 370)
        view.addSubview(signUpButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @objc
    private func signInButtonTapped() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc
    private func signUpButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
}
