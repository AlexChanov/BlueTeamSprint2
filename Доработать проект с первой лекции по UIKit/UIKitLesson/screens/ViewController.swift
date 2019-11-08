//
//  ViewController.swift
//  UIKitLesson
//
//  Created by Kaplan Deniz on 11/10/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Coordinatable {

	weak var delegate: Coordinator?

	var gradientView: GradientView {
		return view as! GradientView
	}

	let button: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
		button.backgroundColor = .gray
		button.setTitle("Redraw", for: .normal)
		button.layer.cornerRadius = 20
		return button
	}()

	let circle: UIView = {
		let view = UIView(frame: CGRect(x: 140, y: 200, width: 100, height: 100))
		view.layer.cornerRadius = 50
		view.backgroundColor = .red
		return view
	}()

    
    override func loadView() {
        let gradientView = GradientView()
        gradientView.colors = [.yellow, .green]
        view = gradientView
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red

		view.addSubview(button)
		view.addSubview(circle)
        
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
		circle.addGestureRecognizer(tapGesture)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		button.center = view.center
	}


	@objc private func redCircleTapped() {
		delegate?.change(self)
	}

	@objc private func buttonTapped() {
		gradientView.colors = UIColor.randomGradientColor()
	}
    
}
