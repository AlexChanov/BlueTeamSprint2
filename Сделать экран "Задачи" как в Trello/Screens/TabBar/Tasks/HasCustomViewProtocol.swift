//
//  HasCustomViewProtocol.swift
//  TrelloCollectionView
//
//  Created by Graf Jenkins on 08/11/2019.
//  Copyright © 2019 Graf Jenkins. All rights reserved.
//

import UIKit

public protocol HasCustomView {
	associatedtype CustomView: UIView
}

extension HasCustomView where Self: UIViewController {
	public var customView: CustomView {
		guard let customView = self.view as? CustomView else {
			fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
		}
		return customView
	}
}

