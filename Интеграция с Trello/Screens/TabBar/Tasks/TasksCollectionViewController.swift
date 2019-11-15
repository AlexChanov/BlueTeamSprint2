//
//  TasksCollectionViewController.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 08/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit
// MARK: - Class
public class TasksViewController:UIViewController {
	// MARK: - ViewControllers properties
	var tasksChildViewControllers = [ListViewController]()
	var addButtonViewController = AddButtonViewController()
}

// MARK: - HasCustomView
extension TasksViewController:HasCustomView {
	public typealias CustomView = TasksCollectionView
}

// MARK: - Lifecycle
extension TasksViewController {
	public override func loadView() {
		super.loadView()
		view = CustomView()

	}
	public override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = tabBarItem.title
		addButtonViewControllerSetUp()
		//
        TrelloManager.shared.delegate = self
		customView.collectionView.delegate = self
		customView.collectionView.dataSource = self
	}
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.isTranslucent = false
        // load board
        TrelloManager.shared.updateTaskBoard()
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.navigationBar.isTranslucent = false
	}
}

// MARK: - TrelloManager delegate
extension TasksViewController: TrelloManagerDelegate {
    
    func updateBoard(with board: TrelloTaskBoard) {
        for list in board.lists {
            let listVC = ListViewController(with: list.name, id: list.id)
            self.addChild(listVC)
            listVC.didMove(toParent: self)
            listVC.tasks = list.tasks
            tasksChildViewControllers.append(listVC)
        }
        DispatchQueue.main.async {
            self.customView.collectionView.reloadData()
        }
    }
    
}

// MARK: - CollectionView delegate
extension TasksViewController:UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height = collectionView.bounds.height - 40
		let width = collectionView.bounds.width - 40
		return CGSize(width: width, height: height)
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		if self.tasksChildViewControllers.count == 0 {
			// If tasks section is empty -> exclude left inset
			return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 20)
		}
		return 	UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
	}
}

// MARK: - CollectionView data source
extension TasksViewController:UICollectionViewDataSource {
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
    
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case 0:
			return tasksChildViewControllers.count
		default:
			return 1
		}
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsefulCell.reuseIdentifier, for: indexPath) as! UsefulCell
		switch indexPath.section {
		case 0:
			cell.hostedView = tasksChildViewControllers[indexPath.row].view
		default:
			cell.hostedView = addButtonViewController.view
		}
		return cell
	}
}

// MARK: - Add button set up
extension TasksViewController {
	private func addButtonViewControllerSetUp() {
		addChild(addButtonViewController)
		addButtonViewController.didMove(toParent: self)
		addButtonViewController.customView.buttonHandler = {[unowned self] title in
			let indexPath = IndexPath(row: self.tasksChildViewControllers.count, section: 0)
            let newTasksListViewController = ListViewController(with: title, id: "")
			self.addChild(newTasksListViewController)
			newTasksListViewController.didMove(toParent: self)
			self.tasksChildViewControllers.append(newTasksListViewController)
			self.customView.collectionView.insertItems(at: [indexPath])
			self.customView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		}
	}
}
