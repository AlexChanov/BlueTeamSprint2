//
//  RootViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
        self.current = WelcomeViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
		//
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    public func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        //
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        //
        current = new
    }
    
    public func switchToMainScreen() {
        animateFadeTransition(to: MyTabBarController())
    }
    
    public func switchToLogout() {
        let logoutScreen = UINavigationController(rootViewController: LoginViewController())
        animateDismissTransition(to: logoutScreen)
    }
    

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//        _ = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}
