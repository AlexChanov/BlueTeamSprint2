//
//  NoteModel.swift
//  AppStructure
//
//  Created by Oleg Azhel on 16.11.2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class NoteModel:NSObject {
	var serverIndex:Int!
	var text: String!
	var image: UIImage?
	var imageUrl: String!
	init(_ note: Note, serverIndex: Int) {
		self.text = note.body
		self.imageUrl = note.imageUrl
		self.serverIndex = serverIndex
	}

	init(note:String, image:UIImage) {
		self.text = note
		self.image = image
	}
}

struct Note: Codable {
	let body: String
	let imageUrl: String
}
