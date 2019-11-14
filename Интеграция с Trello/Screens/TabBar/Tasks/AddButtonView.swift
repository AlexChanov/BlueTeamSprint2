//
//  AddButtonView.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 10/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Class
public class AddButtonView: UIView {
	
	// MARK: - Button completion handler
	public var buttonHandler: ((String) -> ())?

	// MARK: - UI
	// main button
	private lazy var buttonHeightConstraint:NSLayoutConstraint = {
		return NSLayoutConstraint(item: addButton,
								  attribute: .height,
								  relatedBy: .equal,
								  toItem: nil,
								  attribute: .height,
								  multiplier: 1,
								  constant: frame.height / 12)
	}()
	private let addButton:UIButton = {
		let button = UIButton.system(with: "Add")
		button.addTarget(self, action: #selector(addButtonSelector),
						 for: .touchUpInside)
		return button
	}()
	// textfield
	private let textField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "List name?"
		textField.backgroundColor = .white
		textField.keyboardType = .twitter
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	// textFieldBackgroundView - helper to avoid insets suffering
	private let textFieldBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 5
		view.layer.borderColor = UIColor.darkGray.cgColor
		view.layer.borderWidth = 1
		return view
	}()
	// cancel
	private let cancelButton:UIButton = {
		let button = UIButton()
		button.setTitle("Cancel", for: .normal)
		button.titleLabel?.textAlignment = .left
		button.addTarget(self, action: #selector(cancelButtonSelector),
						 for: .touchUpInside)
		return button
	}()
	// done
	private let doneButton:UIButton = {
		let button = UIButton()
		button.setTitle("Done", for: .normal)
		button.addTarget(self, action: #selector(doneButtonSelector),
						 for: .touchUpInside)
		button.titleLabel?.textAlignment = .right
		return button
	}()
	// helper stacView for buttons above -> 2
	private lazy var buttonsStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 10
		return stackView
	}()
}

// MARK: - Layout
extension AddButtonView {
	public func inititalLayoutAnd() {
		addSubview(addButton)
		addButton.addConstraint(buttonHeightConstraint)
		addButton.leadingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.leadingAnchor).isActive = true
		addButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
		addButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true

	}
	private func textFieldLayout() {
		addSubview(textFieldBackgroundView)
		textFieldBackgroundView.leadingAnchor.constraint(equalTo: addButton.leadingAnchor,
														 constant: 10).isActive = 	true
		textFieldBackgroundView.topAnchor.constraint(equalTo: addButton.topAnchor,
													 constant: 10).isActive = true
		textFieldBackgroundView.trailingAnchor.constraint(equalTo: addButton.trailingAnchor,
														  constant: -10).isActive = true
		textFieldBackgroundView.heightAnchor.constraint(equalToConstant: buttonHeightConstraint.constant / 3).isActive = true
		textFieldBackgroundView.widthAnchor.constraint(equalToConstant: bounds.width - 20).isActive = true
		addSubview(textField)
		textField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor,
										   constant: 1).isActive = true
		textField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor,
										   constant: 5).isActive = true
	
		textField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor,
											constant: -5).isActive = true
		textField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor,
										  constant: -1).isActive = true
	}
	private func buttonsStackLayout() {
		addSubview(buttonsStackView)
		buttonsStackView.leadingAnchor.constraint(equalTo: addButton.leadingAnchor).isActive = true
		buttonsStackView.bottomAnchor.constraint(equalTo: addButton.bottomAnchor,
												 constant: -10).isActive = true
		buttonsStackView.trailingAnchor.constraint(equalTo: addButton.trailingAnchor).isActive = true
		buttonsStackView.heightAnchor.constraint(equalToConstant: buttonHeightConstraint.constant / 3).isActive = true
	}
}

// MARK: - Selectors -> Buttons
extension AddButtonView {
	// add button
	@objc private func addButtonSelector() {
		addButton.isEnabled = false
		UIView.animate(withDuration: 0.5, animations: {[unowned self] in
			self.addButton.titleLabel?.alpha = 0
			self.buttonHeightConstraint.constant *= 2
			self.buttonsStackLayout()
			self.textFieldLayout()
			self.layoutIfNeeded()
		})
		self.textField.becomeFirstResponder()
	}
	// cancel button
	@objc private func cancelButtonSelector() {
		addButton.isEnabled = true
		UIView.animate(withDuration: 0.3, animations: {[unowned self] in
			self.addButton.titleLabel?.alpha = 1
			self.buttonHeightConstraint.constant /= 2
			self.buttonsStackView.removeFromSuperview()
			self.textFieldBackgroundView.removeFromSuperview()
			self.textField.removeFromSuperview()
			self.layoutIfNeeded()
		})
		textField.text = ""
		textField.resignFirstResponder()
	}
	// done button
	@objc private func doneButtonSelector() {
		guard let doneButtonHandler = buttonHandler else {
			fatalError("Forgot handler?")
		}
		guard textField.text?.count != 0 else {
			return
		}
		doneButtonHandler(textField.text!)
		cancelButtonSelector()
	}
}
