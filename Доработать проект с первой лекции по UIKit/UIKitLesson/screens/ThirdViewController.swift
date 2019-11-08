//
//  ThirdViewController.swift
//  UIKitLesson
//
//  Created by VadimQw  on 08/11/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let circle: GradientView = {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.cornerRadius = 50
        view.colors = UIColor.randomGradientColor()
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggingView))
        circle.addGestureRecognizer(panGesture)
        view.addSubview(circle)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        circle.center = view.center
    }
    
    
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func draggingView (_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        circle.center = point
        circle.colors = UIColor.randomGradientColor()
    }
    
}
