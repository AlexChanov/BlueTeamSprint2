//
//  CustomButton.swift
//  AppStructure
//
//  Created by VadimQw  on 12/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

extension UIButton {
    
    public static func system(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 200, height: 50)
        button.backgroundColor = .darkBlue
        button.layer.cornerRadius = 10
        // title
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .buttonTitle
        button.titleLabel?.textAlignment = .center
        return button
    }
    
    public static func close() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.tintColor = .black
        return button
    }
    
}
