//
//  UIColor.swift
//  UIKitLesson
//
//  Created by VadimQw  on 08/11/2019.
//  Copyright © 2019 DK. All rights reserved.
//

import UIKit

extension UIColor {
    
    static private func random() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...255) / 255,
                       green: CGFloat.random(in: 0...255) / 255,
                       blue: CGFloat.random(in: 0...255) / 255,
                       alpha: 1)
    }
    
    static func randomGradientColor() -> [UIColor] {
        return [.random(), .random()]
    }
    
    static func gradientColorFor(_ point: CGPoint, size: CGSize) -> [UIColor] {
        let x = point.x / (size.width / 255)
        let y = point.y / (size.height / 255)
        
        let firstColor = UIColor(red: x / 255, green: y / 255, blue: 200 / 255, alpha: 1)
        let secondColor = UIColor(red: 200 / 255, green: x / 255, blue: y / 255, alpha: 1)
        
        return [firstColor, secondColor]
    }
    
}
