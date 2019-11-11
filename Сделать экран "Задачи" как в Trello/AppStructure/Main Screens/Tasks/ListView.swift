//
//  ListView.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 11/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Class
public class ListView: UIView {
	// MARK: - Completion handlers
	public var newTaskHandler:(()->())!
	
	// MARK: - Init
	override public init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .blue
		layer.cornerRadius = 10
	}
	required public init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
	
	// MARK: - UI
	// tableView
	public let tableView:UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(NestedTableViewCell.self,
						   forCellReuseIdentifier: NestedTableViewCell.reuseIdentifier)
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		tableView.backgroundColor = .none
		return tableView
	}()
	
	// Top text field
	private let topTextField:UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .blue
		//
		textField.isEnabled = false
		//
		textField.translatesAutoresizingMaskIntoConstraints = false
		let fontSize = textField.font?.pointSize
		textField.font = UIFont.boldSystemFont(ofSize: fontSize! + 3)
		return textField
	}()
	// helper
	private let topTextFieldBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .blue
		view.layer.cornerRadius = 5
		return view
	}()
	// add card
	private let addCardButton:UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Add card", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.backgroundColor = .blue
		button.addTarget(self, action: #selector(addCardButtonSelector),
						 for: .touchUpInside)
		return button
	}()
}

// MARK: - Layout
extension ListView {
	public func initialLayout(_title:String) {
		topTextField.text = _title
		topTextFieldLayout()
		addButtonLayout()
		tableViewLayout()
	}
	private func topTextFieldLayout() {
		addSubview(topTextFieldBackgroundView)
		topTextFieldBackgroundView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
															constant: 10).isActive = true
		topTextFieldBackgroundView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor,
														constant: 10).isActive = true
		topTextFieldBackgroundView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
															 constant: -10).isActive = true
		topTextFieldBackgroundView.heightAnchor.constraint(equalToConstant: bounds.height / 15).isActive = true
		addSubview(topTextField)
		topTextField.leadingAnchor.constraint(equalTo: topTextFieldBackgroundView.leadingAnchor,
											  constant: 5).isActive = true
		topTextField.topAnchor.constraint(equalTo: topTextFieldBackgroundView.topAnchor,
										  constant: 5).isActive = true
		topTextField.trailingAnchor.constraint(equalTo: topTextFieldBackgroundView.trailingAnchor,
											   constant: -5).isActive = true
		topTextField.bottomAnchor.constraint(equalTo: topTextFieldBackgroundView.bottomAnchor,
											 constant: -5).isActive = true
	}
	private func addButtonLayout() {
		addSubview(addCardButton)
		addCardButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
											   constant: 10).isActive = true
		addCardButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
											  constant: -10).isActive = true
		addCardButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
												constant: -10).isActive = true
		addCardButton.heightAnchor.constraint(equalToConstant: bounds.height / 15).isActive = true
	}
	private func tableViewLayout() {
		addSubview(tableView)
		tableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,
										   constant: 10).isActive = true
		tableView.topAnchor.constraint(equalTo: topTextFieldBackgroundView.bottomAnchor,
									   constant: 10).isActive = true
		tableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,
											constant: -10).isActive = true
		tableView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -10).isActive = true
	}
}

// MARK: - Selectors -> Buttons
extension ListView {
	// done button
	@objc private func addCardButtonSelector() {
		guard let newTaskHandler = newTaskHandler else {
			fatalError("Forgot handler for new task")
		}
		UIView.animate(withDuration: 0.3, animations: {
			newTaskHandler()
		})
	}
}
