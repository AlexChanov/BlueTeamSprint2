//
//  TasksCollectionView.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 08/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

// MARK: - Layout
public class TasksCollectionView: UIView {
	// MARK: - Init
	override public init(frame: CGRect) {
		super.init(frame: frame)
		collectionViewLayout()
	}
	required public init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
	
	// MARK: - CollectionView
	public let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 40
		let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		let collectionView = UICollectionView(frame: frame,
											  collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.isPagingEnabled = true
		collectionView.backgroundColor = .white
		collectionView.register(UsefulCell.self, forCellWithReuseIdentifier: "Tasks")
		collectionView.register(UsefulCell.self, forCellWithReuseIdentifier: UsefulCell.reuseIdentifier)
		return collectionView
	}()
}

// MARK: - UI layout
private extension TasksCollectionView {
	private func collectionViewLayout() {
		addSubview(collectionView)
		let margins = layoutMarginsGuide
		collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
	}
}

