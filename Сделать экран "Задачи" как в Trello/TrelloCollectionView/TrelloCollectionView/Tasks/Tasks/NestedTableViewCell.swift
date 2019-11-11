//
//  NestedTableViewCell.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 11/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit
// MARK: - Class
public class NestedTableViewCell:UITableViewCell {
	// MARK: - Properties
	static let reuseIdentifier = "NestedCell"
	
	// MARK: - Init
	override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .none
		layout()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI
	// Top text field
	public let textField:UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .white
		//
		textField.isEnabled = false
		//
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	// helper
	private let textFieldBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.darkGray.cgColor
		view.layer.cornerRadius = 5
		return view
	}()
}

// MARK: - Layout
extension NestedTableViewCell {
	private func layout() {
		contentView.addSubview(textFieldBackgroundView)
		textFieldBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
														 constant: 5).isActive = true
		textFieldBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		textFieldBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
														  constant: -5).isActive = true
		textFieldBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
														constant: -5).isActive = true
		contentView.addSubview(textField)
		textField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor,
										   constant: 5).isActive = true
		textField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor, constant: 5).isActive = true
		textField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor,
											constant: -5).isActive = true
		textField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor,
										  constant: -5).isActive = true
	}
}

// MARK: - Public
extension NestedTableViewCell {
	public func setTextFieldText(_ text:String) {
		textField.text = text
	}
}
