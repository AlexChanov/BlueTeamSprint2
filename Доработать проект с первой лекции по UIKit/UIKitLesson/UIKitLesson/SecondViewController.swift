//
//  SecondViewController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Второй Controller"
		view.backgroundColor = .white
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
}
