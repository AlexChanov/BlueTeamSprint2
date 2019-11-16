//
//  EditNoteView.swift
//  AppStructure
//
//  Created by Oleg Azhel on 16.11.2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

public class EditNoteView:UIView {
	// MARK: - Init
	override public init(frame: CGRect) {
		super.init(frame: frame)
		NotificationCenter.default.addObserver(self,
				selector: #selector(keyboardWillShow),
				name: UIResponder.keyboardWillShowNotification,
				object: nil)
		stackBottomConstraint = stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
				constant: -15)
		setupLayout()
		//
		textView.delegate = self
	}
	required public init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}

	// MARK: - Constraints
	private var stackBottomConstraint:NSLayoutConstraint!
	public var tabBarHeight:CGFloat!

	// MARK: - UI
	public let imageButton: UIButton = {
		let button = UIButton.system(with: "Add\npicture")
		button.imageView?.contentMode = .scaleAspectFill
		button.imageView?.layer.cornerRadius = 5
		return button
	}()
	public let textView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.textAlignment = .left
		textView.textColor = .black
		textView.font = UIFont.systemFont(ofSize: 18)
		textView.isEditable = true
		textView.isScrollEnabled = true
		textView.layer.cornerRadius = 5
		textView.layer.borderWidth = 0.5
		textView.layer.borderColor = UIColor.black.cgColor
		return textView
	}()
	private lazy var stackView:UIStackView = {
		let stack = UIStackView(arrangedSubviews:
		[self.imageButton, self.textView])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 15
		stack.distribution = .fillEqually
		return stack
	}()
}

// MARK: - Layout
extension EditNoteView {
	private func setupLayout() {
		addSubview(stackView)
		let margins = layoutMarginsGuide
		stackView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15).isActive = true
		stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		stackBottomConstraint.isActive = true
	}
}

// MARK: - Layout if keyboard appears
extension EditNoteView {
	@objc
	private func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let keyboardHeight: CGFloat = keyboardSize.height
			UIView.animate(withDuration: 0.5, animations: {[unowned self] in
				self.imageButton.removeFromSuperview()
				self.stackBottomConstraint.constant -= keyboardHeight - self.tabBarHeight
				self.layoutIfNeeded()
			})
		}
	}
}

// MARK: - NavBar helper
extension EditNoteView {
	public func dataCompleted() -> Bool {
		return imageButton.imageView!.image != nil && textView.text.count != 0
	}
}

// MARK: - TextView delegate
extension EditNoteView:UITextViewDelegate {
	public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		return imageButton.imageView!.image != nil
	}
}
