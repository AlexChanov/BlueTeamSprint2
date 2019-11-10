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
    
    var notesList: [String] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let tableView = UITableView()
      

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Заметки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
        setupLayout()


        
    }
    
    @objc
    func composeTapped() {
        let newNoteVC = NewNoteViewController()
        newNoteVC.delegate = self
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
   private func setupLayout() {
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive               = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive        = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                     = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                   = true
    tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                     = true
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.layer.borderWidth = 0.5
    tableView.layer.borderColor = UIColor.black.cgColor
    tableView.separatorStyle = .singleLine
    tableView.rowHeight = 100
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.reuseId)
    }
    

}



extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseId, for: indexPath) as! NotesTableViewCell
        
        let note = notesList[indexPath.row]
        
        cell.notesLabel.text = note
        
        return cell 
    }
    
    
}
