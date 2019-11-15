//
//  PresentViewControlle.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 15/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController {
    
    private let blackCard = CustomView()
    private let grayCard = CustomView()
    private let blueCard = CustomView()
    private let redCard = CustomView()
    private let tappImage = UIImageView()
    
    private let trelloLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 40)
        textLabel.text = "Trello"
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewLayout()
        labelLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateViews()
    }
    
    private func animateViews() {
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
            self.tappImage.center.x = self.redCard.center.x
            self.tappImage.center.y = self.redCard.center.y + 30.00
            
        }) { (result) in
            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                self.tappImage.center.x = self.tappImage.center.x + 40
                
            }, completion: { (result) in
                
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.tappImage.center.x = self.tappImage.center.x - 60
                    
                }, completion: { (result) in
                    
                    UIView.animate(withDuration: 0.1, delay: 1.5, options: [], animations: {
                        self.tappImage.center.x = self.tappImage.center.x - 40
                        
                    }, completion: { (result) in
                        UIImageView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                            self.tappImage.center.x = self.tappImage.center.x + 30
                            
                        }, completion: { (result) in
                            
                        })
                        
                    })
                })
                
            })
        }
        
        UIView.animate(withDuration: 1, delay: 1.5, options: [], animations: {
            let widthView = self.view.frame.width/2
            self.redCard.frame = CGRect(x: self.grayCard.frame.maxX + 1000, y: self.grayCard.frame.maxY - 500, width: widthView, height: widthView)
            
        }) { (result) in
            
            UIView.animate(withDuration: 1, delay: 1.2 , options: [], animations: {
                let widthView = self.view.frame.width/2
                self.grayCard.frame = CGRect(x: self.grayCard.frame.maxX - 1000, y: self.grayCard.frame.maxY + 200, width: widthView, height: widthView)
            }) { (result) in
                UIView.animate(withDuration: 0.5, delay: 1, options: [.autoreverse], animations: {
                    self.tappImage.frame.size = CGSize(width: self.tappImage.frame.width * 2, height: self.tappImage.frame.height * 2)
                    
                }, completion: { (result) in
                    self.tappImage.isHidden = true
                    self.trelloLabel.isHidden = true
                    self.animationImage()
                    
                })
            }
            
        }
    }
    
    private func animationImage() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blueCard.transform = CGAffineTransform(scaleX: 10 ,y: 10)
            self.blackCard.layer.opacity = 0
            self.blueCard.transform = CGAffineTransform(rotationAngle: 361)
        }) { (Bool) in
            AppDelegate.shared.rootViewController.switchToWelcomScreen()
        }
    }
}


// MARK: - Layout
extension PresentViewController {
    private func labelLayout() {
        view.addSubview(trelloLabel)
        let margins = view.layoutMarginsGuide
        trelloLabel.bottomAnchor.constraint(lessThanOrEqualTo: blackCard.topAnchor, constant: -60).isActive = true
        trelloLabel.heightAnchor.constraint(equalToConstant: 100)
        trelloLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        trelloLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    private func viewLayout() {
        let widthView = view.frame.width/2
        let viewCenterX = self.view.center.x
        let viewCenterY = self.view.center.y
        
        
        redCard.frame = CGRect(x: viewCenterX-70, y: viewCenterY-80, width: widthView, height: widthView)
        redCard.label.text = "Оранжевая команда"
        redCard.backgroundColor = .orange
        
        
        grayCard.frame = CGRect(x: viewCenterX-90, y: viewCenterY-100, width: widthView, height: widthView)
        grayCard.label.text = "Cерая команда"
        grayCard.backgroundColor = .gray
        
        
        blueCard.frame = CGRect(x: viewCenterX-110, y: viewCenterY-120, width: widthView, height: widthView)
        blueCard.label.text = "Синяя команда"
        blueCard.backgroundColor = .darkBlue
        
        
        blackCard.frame = CGRect(x: viewCenterX-130, y: viewCenterY-140, width: widthView, height: widthView)
        blackCard.label.text = "Черная команда"
        blackCard.backgroundColor = .black
        
        
        tappImage.image = UIImage(named: "TapFinger")
        tappImage.center.y = self.view.center.y + 200
        tappImage.center.x = self.view.center.x
        tappImage.frame.size = CGSize(width: blackCard.frame.width/2, height: blackCard.frame.width/1.5)
        
        
        self.view.addSubview(blackCard)
        self.view.addSubview(blueCard)
        self.view.addSubview(grayCard)
        self.view.addSubview(redCard)
        self.view.addSubview(tappImage)
    }
}
