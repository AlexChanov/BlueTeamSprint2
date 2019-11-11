//
//  ListViewController.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 11/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Class
public class ListViewController: UIViewController {
	// MARK: - Properties
	private var initialTitle:String?
	// tmp tasks
	// Все этоу потому в структурку
	// Как и название
	private var tasks = [String]() {
		didSet {
			let indexPath = IndexPath(row: oldValue.count, section: 0)
			customView.tableView.insertRows(at: [indexPath], with: .fade)
		}
	}
}

// MARK: - Init
extension ListViewController {
	public convenience init(with title: String) {
		self.init(nibName: nil, bundle: nil)
		self.initialTitle = title
	}
}

// MARK: - HasCustomView
extension ListViewController:HasCustomView {
	public typealias CustomView = ListView
}

// MARK: - Lifecycle
extension ListViewController {
	public override func loadView() {
		super.loadView()
		view = CustomView()
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		customView.tableView.dataSource = self
		customView.tableView.delegate = self
		customView.newTaskHandler = {[unowned self] in
			self.newTaskAlertController()
		}
	}
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let initialTitile = initialTitle {
			customView.initialLayout(_title: initialTitile)
			self.initialTitle = nil
		}
	}
}

// MARK: - Nested table view data source
extension ListViewController: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NestedTableViewCell.reuseIdentifier,
												 for: indexPath) as! NestedTableViewCell
		cell.setTextFieldText(tasks[indexPath.row])
		return cell
	}
}
// MARK: - Nested table view delegate
extension ListViewController:UITableViewDelegate {
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.height / 8
	}
}

// MARK: - Text alert
extension ListViewController {
	private func newTaskAlertController() {
		let alertController = UIAlertController(title: "Add task", message: "Please", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		alertController.addTextField(configurationHandler: {textField in
			textField.autocapitalizationType = .sentences
			textField.placeholder = "Task to done"
		})
		let doneAction = UIAlertAction(title: "Done", style: .default, handler: {[unowned self] _ in
			let textField = alertController.textFields![0]
			guard textField.text!.count != 0 else {
				return
			}
			self.tasks.append(textField.text!)
		})
		alertController.addAction(doneAction)
		present(alertController, animated: true, completion: nil)
	}
}
