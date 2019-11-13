//
//  NotesTableViewCell.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 10/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

	public static let reuseIdentifier = "notesCell"
	private let notesLabelHeightConstraint:NSLayoutConstraint
    private let fadeLabelIn = CABasicAnimation(keyPath: "opacity")

	// MARK: - UI
	public let notesLabel:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .white
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = false
		label.backgroundColor = .blue
        label.layer.opacity = 0
		label.font = UIFont.systemFont(ofSize: 18)
		return label
	}()
	// helper
	private let labelView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .blue
		view.layer.cornerRadius = 5
		return view
	}()
	// MARK: - Init
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	notesLabelHeightConstraint = NSLayoutConstraint(item: notesLabel, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backGroundViewLayout()
		selectionStyle = .none
		buttonLayout()
        disappearContent()
        
	}
    
   private func disappearContent() {
        fadeLabelIn.fromValue = 1
        fadeLabelIn.toValue = 0
        fadeLabelIn.duration = 5
        fadeLabelIn.repeatCount = 1
        notesLabel.layer.add(fadeLabelIn, forKey: "fadein")
    }
    
     func appearContent() {
        fadeLabelIn.fromValue = 0
        fadeLabelIn.toValue = 1
        fadeLabelIn.duration = 5
        fadeLabelIn.repeatCount = 1
        notesLabel.layer.add(fadeLabelIn, forKey: "fadein")
        var _: Timer = Timer.scheduledTimer(withTimeInterval: 4.8, repeats: false, block: { _ in self.disappearContent()})
    }
    
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Layout
extension NotesTableViewCell {
	private func buttonLayout() {
		contentView.addSubview(notesLabel)
		notesLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 5).isActive           		= true
		notesLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 5).isActive   		= true
		notesLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -5).isActive		= true
		notesLabel.bottomAnchor.constraint(lessThanOrEqualTo: labelView.bottomAnchor, constant: -5).isActive = true
		notesLabel.addConstraint(notesLabelHeightConstraint)
	}
	private func backGroundViewLayout() {
		contentView.addSubview(labelView)
		labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive				= true
		labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive		= true
		labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive		= true
		labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive	= true
	}
}

// MARK: - Enlarge
extension NotesTableViewCell {
	public func changeConstraint() {
		notesLabelHeightConstraint.isActive = !notesLabelHeightConstraint.isActive
	}
}
