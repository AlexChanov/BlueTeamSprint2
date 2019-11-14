//
//  UIKitForProject.swift
//  AppStructure
//
//  Created by VadimQw  on 12/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

// MARK: - Project fonts
extension UIFont {
    @nonobjc class var textTitle: UIFont {
        return .systemFont(ofSize: 24, weight: .bold)
    }
    
    @nonobjc class var buttonTitle: UIFont {
        return .systemFont(ofSize: 20, weight: .medium)
    }
}

// MARK: - Project colors
extension UIColor {
    @nonobjc class var lightBlue: UIColor {
        return UIColor(red: 21 / 255, green: 157 / 255, blue: 235 / 255, alpha: 1)
    }
    
    @nonobjc class var darkBlue: UIColor {
        return UIColor(red: 0 / 255, green: 121 / 255, blue: 190 / 255, alpha: 1)
    }
}
