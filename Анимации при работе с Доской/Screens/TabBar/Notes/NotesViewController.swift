//
//  NotesViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

public class NotesViewController: UIViewController {
	// MARK: - Model
	var notesList: [String] = [] {
		didSet{
			navigationItem.title = "Заметки: \(oldValue.count + 1)"
			tableView.reloadData()
		}
	}
	// MARK: - UI
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.estimatedRowHeight = 10
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = .none
		tableView.backgroundColor = .white
		tableView.register(NotesTableViewCell.self,
						   forCellReuseIdentifier: NotesTableViewCell.reuseIdentifier)
		return tableView
	}()
	// MARK: - lifecycle
	override public func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Заметки"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
															target: self,
															action: #selector(composeTapped))
		setupLayout()
		tableView.dataSource = self
		tableView.delegate = self
	}
	// MARK: - Selector
	@objc
	func composeTapped() {
		let newNoteVC = EditNoteViewController()
		newNoteVC.delegate = self
		navigationController?.pushViewController(newNoteVC, animated: true)
	}
	// MARK: - Layout
	private func setupLayout() {
		self.view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive               = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive        = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                     = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                   = true
	}
}

//MARK: - TableViewDataSource
extension NotesViewController :  UITableViewDataSource {
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notesList.count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseIdentifier,
												 for: indexPath) as! NotesTableViewCell
		let note = notesList[indexPath.row]
		cell.notesLabel.text = "\(indexPath.row + 1). \(note)"
		return cell
	}
    

}

// MARK: - TableViewDelegate
extension NotesViewController:UITableViewDelegate {
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! NotesTableViewCell
		cell.changeConstraint()
		cell.layoutIfNeeded()
        cell.appearContent()
		tableView.beginUpdates()
		tableView.endUpdates()
		tableView.deselectRow(at: indexPath, animated: false)
	}

}


// MARK: - Text data protocol
extension NotesViewController:TextDataUpdateProtocol {
	public func addText(data text: String) {
		notesList.append(text)
	}
}
