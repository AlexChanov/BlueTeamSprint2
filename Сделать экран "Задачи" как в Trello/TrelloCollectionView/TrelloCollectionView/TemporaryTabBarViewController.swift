//
//  TemporaryTabBarViewController.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 08/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Class
public class TemporaryTabBarViewController: UITabBarController {}

// MARK: - 	Lifecycle
extension TemporaryTabBarViewController {
	public override func viewDidLoad() {
		super.viewDidLoad()
		createViewControllers()
	}
}

// MARK: - VCs
extension TemporaryTabBarViewController {
	private func createViewControllers() {
		let tasksViewController = UINavigationController(rootViewController: TasksCollectionViewController())
		let tasksImage = UITabBarItem(tabBarSystemItem: .featured, tag: 0).selectedImage
		tasksViewController.tabBarItem = UITabBarItem(title: "Tasks", image: tasksImage, tag: 0)
		let notesViewController = NotesTableViewContoller()
		let notesImage = UITabBarItem(tabBarSystemItem: .recents, tag: 1).selectedImage
		notesViewController.tabBarItem = UITabBarItem(title: "Notes", image: notesImage, tag: 1)
		viewControllers = [tasksViewController, notesViewController]
		selectedIndex = 0
	}
}
