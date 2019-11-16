//
//  NotesTableViewCell.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 10/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//
import UIKit

class NotesTableViewCell: UITableViewCell {
		
	// MARK: - Model
	weak var noteModel:NoteModel!
	
	// MARK: - Identifier
	public static let reuseIdentifier = "notesCell"
	
	// MARK: - UI and cosntraints
	private let notesLabelHeightConstraint:NSLayoutConstraint!
	private let cellHeightAnchor:CGFloat = UIScreen.main.bounds.width / 4
	
	public let imageButton: GradientButton = {
		let button = GradientButton.system(with: "")
		button.isUserInteractionEnabled = false
		button.imageView?.layer.cornerRadius = 5
		button.imageView?.contentMode = .scaleAspectFill
		button.imageView?.layer.borderWidth = 1
		button.imageView?.layer.borderColor = UIColor.darkBlue.cgColor
		return button
	}()
	
	private let noteLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.clipsToBounds = true
		label.layer.cornerRadius = 10
		label.textAlignment = .left
		label.textColor = .white
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = false
		label.backgroundColor = .darkBlue
		label.font = UIFont.systemFont(ofSize: 18)
		return label
	}()
	
	private let labelView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .darkBlue
		view.layer.cornerRadius = 10
		return view
	}()
	
	private lazy var activityView:UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.center = self.imageButton.center
		indicator.backgroundColor = .darkBlue
		indicator.layer.cornerRadius = 5
		indicator.style = .whiteLarge
		indicator.color = .white
		indicator.startAnimating()
		return indicator
	}()
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		self.notesLabelHeightConstraint = NSLayoutConstraint(item: self.noteLabel, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: cellHeightAnchor - 10)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeightAnchor + 10).isActive = true
		imageButtonLayout()
		backGroundViewLayout()
		noteLabelLayout()
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Public accessors
extension NotesTableViewCell {
	public func setUp(with note:NoteModel) {
		noteModel = note
		noteLabel.text = note.text
		activityIndicatorLayout()
		if let image = noteModel.image {
			imageButton.setImage(image, for: .normal)
			activityView.removeFromSuperview()
		} else {
			DispatchQueue.global().async {
				guard let url = URL(string: self.noteModel.imageUrl) else {
					return
				}
				guard let data = try? Data(contentsOf: url) else {
					return
				}
				guard let image = UIImage(data: data) else {
					return
				}
				self.noteModel.image = image
				DispatchQueue.main.async {
					self.imageButton.setImage(self.noteModel.image!, for: .normal)
					self.activityView.removeFromSuperview()
				}
			}
		}
	}
}

// MARK: - Layout
extension NotesTableViewCell {
	private func imageButtonLayout() {
		contentView.addSubview(imageButton)
		imageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
		imageButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		imageButton.widthAnchor.constraint(equalToConstant: cellHeightAnchor).isActive = true
		imageButton.heightAnchor.constraint(equalToConstant: cellHeightAnchor).isActive = true
	}
	
	private func noteLabelLayout() {
		contentView.addSubview(noteLabel)
		noteLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 5).isActive = true
		noteLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 5).isActive = true
		noteLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -5).isActive = true
		noteLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeightAnchor - 10).isActive = true
		noteLabel.bottomAnchor.constraint(lessThanOrEqualTo: labelView.bottomAnchor, constant: -5).isActive = true
		noteLabel.addConstraint(notesLabelHeightConstraint)
	}
	
	private func backGroundViewLayout() {
		contentView.addSubview(labelView)
		labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive				= true
		labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive		= true
		labelView.leadingAnchor.constraint(equalTo: imageButton.trailingAnchor, constant: 10).isActive		= true
		labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive	= true
	}
	
	public func activityIndicatorLayout() {
		if noteModel.image == nil {
			imageButton.addSubview(activityView)
			activityView.leadingAnchor.constraint(equalTo: imageButton.leadingAnchor).isActive = true
			activityView.topAnchor.constraint(equalTo: imageButton.topAnchor).isActive = true
			activityView.trailingAnchor.constraint(equalTo: imageButton.trailingAnchor).isActive = true
			activityView.bottomAnchor.constraint(equalTo: imageButton.bottomAnchor).isActive = true
		}
	}
}

// MARK: - Enlarge
extension NotesTableViewCell {
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated:animated)
		if selected {
			notesLabelHeightConstraint?.isActive = !notesLabelHeightConstraint!.isActive
			layoutIfNeeded()
		}
	}
}
