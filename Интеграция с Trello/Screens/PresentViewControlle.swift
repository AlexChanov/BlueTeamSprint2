//
//  PresentViewControlle.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 15/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class PresentViewControlle: UIViewController {
    
    let blackCard = CustomView()
    let greenCard = CustomView()
    let blueCard = CustomView()
    let redCard = CustomView()
    let tappImage = UIImageView()
    
    
    let frameY = 300
    let frameX = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redCard.frame = CGRect(x: frameX+90, y: frameY+30, width: 200, height: 200)
        redCard.label.text = "Красная комнада"
        redCard.backgroundColor = .red
        
        greenCard.frame = CGRect(x: frameX+60, y: frameY+20, width: 200, height: 200)
        greenCard.label.text = "Зеленая комнада"
        greenCard.backgroundColor = .green
       
        
        blueCard.frame = CGRect(x: frameX+30, y: frameY+10, width: 200, height: 200)
        blueCard.label.text = "Синяя комнада"
        blueCard.backgroundColor = .blue
       
        
        blackCard.frame = CGRect(x: frameX, y: frameY, width: 200, height: 200)
        blackCard.label.text = "Черная комнада"
        blackCard.backgroundColor = .black
        
        
        tappImage.image = UIImage(named: "tapp")
        tappImage.center.y = self.view.center.y + 100
        tappImage.center.x = self.view.center.x
        tappImage.frame.size = CGSize(width: 100, height: 150)
        
        self.view.addSubview(blackCard)
        self.view.addSubview(blueCard)
        self.view.addSubview(greenCard)
        self.view.addSubview(redCard)
        self.view.addSubview(tappImage)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateViews()
    }
    
    
    func animateViews() {
        
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
                    self.animationImage()
                })
            }
            
        }
    }
    
    
    private func animationImage() {
        UIView.animate(withDuration: 1, animations: {
            self.blueCard.transform = CGAffineTransform(scaleX: 50 ,y: 50)
            self.blueCard.transform = CGAffineTransform(rotationAngle: 361)
            self.blueCard.layer.opacity = 0
        }) { (Bool) in
            
        }
        
    }
    


}
