//
//  FullContentOfNoteViewController.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 10/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class FullContentOfNoteViewController: UIViewController {
    
    var note = ""
    
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18)
        view.isEditable = false
        view.isScrollEnabled = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.text = note 
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Содержание заметки"
        view.backgroundColor = .white
        view.addSubview(textView)
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive               = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive        = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                     = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                   = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
    }
    
}
