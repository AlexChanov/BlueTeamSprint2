//
//  Color+gradient.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 12/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class GradientButton: UIButton {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as? CAGradientLayer ?? CAGradientLayer()
    }
}

extension GradientButton {
    public func animateGradient() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.0)
        let colors:[UIColor] = [.darkBlue, .white]
        gradientLayer.colors = colors.map({ (color) in
            color.cgColor
        })
        let locations: [NSNumber] = [1,1,1]
        gradientLayer.locations = locations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1, 1]
        gradientAnimation.duration = 3
        gradientAnimation.repeatCount = 1
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
}