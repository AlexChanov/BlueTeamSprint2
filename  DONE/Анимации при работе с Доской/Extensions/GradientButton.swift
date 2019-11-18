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
