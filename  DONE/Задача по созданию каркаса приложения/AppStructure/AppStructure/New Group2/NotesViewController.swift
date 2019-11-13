//
//  NotesViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var count = 0 {
        didSet {
            navigationItem.title = "Заметки \(count)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Заметки"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
        
    }
    
    @objc
    func composeTapped() {
        let newNoteVC = NewNoteViewController()
        newNoteVC.delegate = self
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
    
    

}
