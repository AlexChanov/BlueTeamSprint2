//
//  NotesViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//
import UIKit

public class NotesViewController: UIViewController {
	var notesList = [NoteModel]()
	var notesCached = [NoteModel]()
	private var serverNotesQuantity = 0

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
//		for i in 0..<40 {
//			FirebaseClient.putNote(index: i, noteBody: "Note -> \(i)", imageUrl: "https://www.googleapis.com/download/storage/v1/b/blueteamtrello.appspot.com/o/1635488747.jpg?generation=1574101948309306&alt=media", completion: {_,_ in})
//		}
		self.navigationItem.title = "Заметки"
		setupLayout()
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refreshControlerSelector), for: .valueChanged)
		tableView.dataSource = self
		tableView.delegate = self
		startLoad()
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
			tableView.beginUpdates()
			self.tableView.deleteRows(at: [indexPath], with: .fade)
			self.notesList.remove(at: indexPath.row)
			tableView.endUpdates()
			FirebaseClient.deleteNote(index: serverIndex!, completion: {})
		}
	}
	public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let currentOffset = scrollView.contentOffset.y
		if currentOffset < 0 {
			return
		}
		let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
		
		if maximumOffset - currentOffset <= 50 {
			loadNotes()
		}
	}
}

// MARK: - Text data protocol
extension NotesViewController:TextDataUpdateProtocol {
	public func addText(data text: String,
						image: UIImage) {
		let noteModel = NoteModel(note: text,
								  image: image)
		noteModel.serverIndex = serverNotesQuantity

		self.notesList.append(noteModel)
		self.tableView.reloadData()
		FirebaseClient.uploadNew(image: image, handler: {imageUrl in
			FirebaseClient.putNote(index: self.serverNotesQuantity,
								   noteBody: text,
								   imageUrl: imageUrl,
								   completion: {_,_ in
				self.serverNotesQuantity += 1
			})
		})
	}
}

// MARk: - Firebas
extension NotesViewController {
	private func startLoad() {
		FirebaseClient.getNotes(completion: {[unowned self] notes, _ in
			self.serverNotesQuantity = notes.count
			for (index, note) in notes.enumerated() {
				if let note = note {
					DispatchQueue.main.async {
						let noteModel = NoteModel(note, serverIndex: index)
						if index >= 10 && self.notesList.count >= 10 {
							self.notesCached.append(noteModel)
						} else {
							let indexPath = IndexPath(row: self.notesList.count - 1, section: 0)
							self.notesList.append(noteModel)
							self.tableView.beginUpdates()
							self.tableView.insertRows(at: [indexPath], with: .fade)
							self.tableView.endUpdates()
						}
					}
				}
			}
		})
	}
	private func loadNotes() {
		if self.notesCached.isEmpty {
			return
		} else {
			var kek = 0
			for (index, note) in self.notesCached.enumerated() {
				if index + kek == 20 {
					break
				}
				let indexPath = IndexPath(row: self.notesList.count, section: 0)
				self.tableView.beginUpdates()
				self.notesList.append(note)
				self.tableView.insertRows(at: [indexPath], with: .fade)
				self.tableView.endUpdates()
				self.notesCached.remove(at: index - kek)
				kek += 1
			}
		}
	}
}

// MARK: - Refresh control selector
extension NotesViewController {
	@objc
	private func refreshControlerSelector() {
		var indexPaths = [IndexPath]()
		for (index, _) in self.notesList.enumerated() {
			let indexPath = IndexPath(row: index, section: 0)
			indexPaths.append(indexPath)
		}
		tableView.beginUpdates()
		self.notesList.removeAll()
		self.tableView.deleteRows(at: indexPaths, with: .automatic)
		self.tableView.reloadData()
		tableView.endUpdates()
		self.startLoad()
		refreshControl.endRefreshing()
	}
}
