//
//  MyTabBarControllerViewController.swift
//  MyTabBarControllerProgrammatically
//
//  Created by XCodeClub on 2019-11-07.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        
        let tasksVC = TasksViewController()
        tasksVC.title = "Задачи"
        tasksVC.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(named: "list-7"), selectedImage: nil)

        let notesVC = NotesViewController()
        notesVC.tabBarItem = UITabBarItem(title: "Заметки", image: UIImage(named: "layer-7"), tag: 1)
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Настройки"
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "spanner-7"), tag: 2)
        let tabBarList = [tasksVC, notesVC, settingsVC]

        viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
        
    }
    



}
