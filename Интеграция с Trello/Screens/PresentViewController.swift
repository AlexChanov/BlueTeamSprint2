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
    private let greenCard = CustomView()
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
    
    let frameY = 300
    let frameX = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        redCard.frame = CGRect(x: frameX+90, y: frameY+30, width: 200, height: 200)
        redCard.label.text = "Оранжева комнада"
        redCard.backgroundColor = .orange
        
        greenCard.frame = CGRect(x: frameX+60, y: frameY+20, width: 200, height: 200)
        greenCard.label.text = "Cерая комнада"
        greenCard.backgroundColor = .gray
        
        
        blueCard.frame = CGRect(x: frameX+30, y: frameY+10, width: 200, height: 200)
        blueCard.label.text = "Синяя комнада"
        blueCard.backgroundColor = .darkBlue
        
        
        blackCard.frame = CGRect(x: frameX, y: frameY, width: 200, height: 200)
        blackCard.label.text = "Черная комнада"
        blackCard.backgroundColor = .black
        
        
        tappImage.image = UIImage(named: "tappingImage")
        tappImage.center.y = self.view.center.y + 100
        tappImage.center.x = self.view.center.x
        tappImage.frame.size = CGSize(width: 100, height: 150)
        
        self.view.addSubview(blackCard)
        self.view.addSubview(blueCard)
        self.view.addSubview(greenCard)
        self.view.addSubview(redCard)
        self.view.addSubview(tappImage)
        self.view.addSubview(trelloLabel)
        labelLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            self.redCard.frame = CGRect(x: self.frameX+1090, y: self.frameX+30, width: 200, height: 200)
            
        }) { (result) in
            
            UIView.animate(withDuration: 1, delay: 1.2 , options: [], animations: {
                self.greenCard.frame = CGRect(x: self.frameX-1090, y: self.frameX+30, width: 200, height: 200)
                
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
            self.blueCard.transform = CGAffineTransform(rotationAngle: 180)
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
        trelloLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        trelloLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        trelloLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
}
