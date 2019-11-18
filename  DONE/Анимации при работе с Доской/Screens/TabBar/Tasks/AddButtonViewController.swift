//
//  AddButtonViewController.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 10/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Class
public class AddButtonViewController: UIViewController {
	// MARK: - Properties
	// Ранее загружалось
	private var previouslyLoaded = false
}

// MARK: - HasCustomView protocol
extension AddButtonViewController:HasCustomView {
	public typealias CustomView = AddButtonView
}

// MARK: - Lifecycle
extension AddButtonViewController {
	public override func loadView() {
		super.loadView()
		view = CustomView()
	}
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// Добавить проверку, что в сети не пусто
		if !previouslyLoaded {
			previouslyLoaded = true
			customView.inititalLayoutAnd()
		}
	}
}
