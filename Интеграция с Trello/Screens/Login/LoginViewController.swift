//
//  LoginViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Layout
    private let buttonsStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Login"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // navBar
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // signIn button
        let signInButton = UIButton.system(with: "Sign in")
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
//         signUp button
        let signUpButton = UIButton.system(with: "Sign up")
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        // stack
        buttonsStack.addArrangedSubview(signInButton)
        buttonsStack.addArrangedSubview(signUpButton)
        stackLayout()
        // image
        imageLayout()
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

// MARK: - Layout
extension LoginViewController {
    private func stackLayout() {
        view.addSubview(buttonsStack)
        buttonsStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        buttonsStack.heightAnchor.constraint(equalToConstant: 110).isActive = true
        buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    private func imageLayout() {
        view.addSubview(bearImageView)
        bearImageView.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor).isActive = true
        bearImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        bearImageView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor).isActive = true
        bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}