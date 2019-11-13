//
//  SecondViewController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.backgroundColor = .blue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Второй Controller"
		view.backgroundColor = .white
        
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button.center = view.center
    }
    
    @objc private func buttonTapped() {
        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .fullScreen
        present(ThirdViewController(), animated: true, completion: nil)
    }
    
}
