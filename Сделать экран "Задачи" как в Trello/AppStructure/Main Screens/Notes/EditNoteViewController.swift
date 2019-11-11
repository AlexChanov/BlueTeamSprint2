//
//  NewNoteViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    var delegate: TextDataUpdateProtocol!
	var note:String? = nil
    
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
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
		if note == nil {
			 navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
			textView.isEditable = true
			textView.becomeFirstResponder()
		} else {
			navigationItem.title = "Содержание заметки"
			textView.text = note!
		}
    }
    @objc
    func saveTapped() {
		guard textView.text.count != 0 else {
			return
		}
		delegate.addText(data: textView.text)
		navigationController?.popViewController(animated: true)
    }
    private func setupLayout() {
        view.addSubview(textView)
		textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive               = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive        = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                     = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                   = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
    }
}
