//
//  AddButtonCell.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 08/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

public class UsefulCell:UICollectionViewCell {
	
	static let reuseIdentifier = "Cell"

	public var hostedView: UIView? {
		didSet {
			guard let hostedView = hostedView else {
				return
			}
			hostedView.frame = contentView.bounds
			contentView.addSubview(hostedView)
		}
	}
	
	// MARK: - Reuse
	override public func prepareForReuse() {
		super.prepareForReuse()
		if hostedView?.superview == contentView {
			hostedView?.removeFromSuperview()
		}
		hostedView = nil
	}
}
