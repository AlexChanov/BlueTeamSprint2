//
//  MyTabBarControllerViewController.swift
//  MyTabBarControllerProgrammatically
//
//  Created by XCodeClub on 2019-11-07.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

final class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        let tasksVC = TasksViewController()
        tasksVC.title = "Задачи"
        tasksVC.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(named: "Tasks"), tag: 0)

        let notesVC = NotesViewController()
        notesVC.tabBarItem = UITabBarItem(title: "Заметки", image: UIImage(named: "Notes"), tag: 1)
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Настройки"
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "Settings"), tag: 2)
        
        let tabBarList = [tasksVC, notesVC, settingsVC]
        viewControllers = tabBarList.map { UINavigationController(rootViewController: $0) }
		selectedIndex = 1
    }
}
