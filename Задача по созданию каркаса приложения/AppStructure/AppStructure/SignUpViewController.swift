
//
//  SignUpViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let attributedText = NSMutableAttributedString(string: "Извините, данная функция сейчас недоступна.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nЗарегистрируйтесь через сайт.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        descriptionTextView.center = view.center
        view.addSubview(descriptionTextView)
        
        
    }
    

    
}
