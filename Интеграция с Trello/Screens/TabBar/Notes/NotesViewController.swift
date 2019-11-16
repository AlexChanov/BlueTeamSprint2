//
//  NotesViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//
import UIKit

public class NotesViewController: UIViewController {
	
	var notesList = [NoteModel]() {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	// MARK: - UI
	private let refreshControl = UIRefreshControl()
	
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

	// MARK: - Lifecycle
	override public func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "Заметки"
		setupLayout()
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refreshControlerSelector), for: .valueChanged)
		tableView.dataSource = self
		tableView.delegate = self
		loadNotes()
		view.backgroundColor = .white
		navigationItem.title = "Заметки"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
															target: self,
															action: #selector(composeTapped))
		
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
		cell.setUp(with: note)
		return cell
	}
}

// MARK: - TableViewDelegate
extension NotesViewController:UITableViewDelegate {
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.performBatchUpdates(nil)
		tableView.deselectRow(at: indexPath, animated: false)
	}

	public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let note = notesList[indexPath.row]
		(cell as! NotesTableViewCell).setUp(with: note)
	}
	
	public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let serverIndex = notesList[indexPath.row].serverIndex
			print(notesList[indexPath.row].imageUrl!)
			tableView.beginUpdates()
			self.tableView.deleteRows(at: [indexPath], with: .fade)
			self.notesList.remove(at: indexPath.row)
			tableView.endUpdates()
			FirebaseClient.deleteNote(index: serverIndex!, completion: {})
		}
	}
}

// MARK: - Text data protocol
extension NotesViewController:TextDataUpdateProtocol {
	public func addText(data text: String,
						image: UIImage) {
		let index:Int
		if notesList.count == 0 {
			index = 0
		} else {
			index = notesList[notesList.count - 1].serverIndex! + 1
		}
		let noteModel = NoteModel(note: text,
								  image: image)
		noteModel.serverIndex = index
		self.notesList.append(noteModel)
		FirebaseClient.uploadNew(image: image, handler: {imageUrl in
		FirebaseClient.putNote(index: index,
								   noteBody: text,
								   imageUrl: imageUrl,
								   completion: {_,_ in})
		})
	}
}

// MARk: - Firebas
extension NotesViewController {
	private func loadNotes() {
		FirebaseClient.getNotes(completion: {[unowned self] notes, _ in
			self.notesList.removeAll()
			for index in 0..<notes.count {
				if let note = notes[index] {
					let model = NoteModel(note, index: index)
					self.notesList.append(model)
				}
			}
		})
	}
}

// MARK: - Refresh control selector
extension NotesViewController {
	@objc
	private func refreshControlerSelector() {
		self.loadNotes()
		refreshControl.endRefreshing()
	}
}
