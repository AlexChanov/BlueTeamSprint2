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
    
}
