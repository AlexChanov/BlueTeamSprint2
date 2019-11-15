//
//  CustomView.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 15/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 10
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
