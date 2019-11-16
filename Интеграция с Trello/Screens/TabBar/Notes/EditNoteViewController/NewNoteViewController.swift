//
//  NewNoteViewController.swift
//  AppStructure
//
//  Created by Oleg Azhel on 16.11.2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
	// MARK: - UI
	private lazy var indicatorView:UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		indicator.center = customView.center
		indicator.backgroundColor = .white
		indicator.layer.cornerRadius = 5
		indicator.style = .whiteLarge
		indicator.color = .darkBlue
		customView.addSubview(indicator)
		return indicator
	}()
	private lazy var imagePicker: UIImagePickerController = {
		let picker = UIImagePickerController()
//		picker.sourceType = UIImagePickerController.SourceType.photoLibrary
		picker.allowsEditing = false
		picker.modalPresentationStyle = .overCurrentContext
		picker.modalTransitionStyle = .crossDissolve
		return picker
	}()
	// MARK: - Properties
	var delegate: TextDataUpdateProtocol!
}

// MARK: - HasCustomView protocol
extension EditNoteViewController:HasCustomView {
    typealias CustomView = EditNoteView
}

// MARK: - Lifestyle
extension EditNoteViewController {
	open override func loadView() {
		super.loadView()
		view = CustomView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Заметка"
		//
		customView.tabBarHeight = tabBarController?.tabBar.frame.height
		customView.imageButton.addTarget(self,
				action: #selector(pickerController),
				for: .touchUpInside)
		//
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
					style: .plain,
					target: self,
					action: #selector(saveTapped))
	}
}

// MARK: - Picker controller
extension EditNoteViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let image = info[.originalImage] as? UIImage {
			let selectedImage : UIImage = image
			customView.imageButton.setImage(selectedImage, for: .normal)
			indicatorView.removeFromSuperview()
			indicatorView.stopAnimating()
			picker.dismiss(animated: true)
		}
	}

	public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		indicatorView.removeFromSuperview()
		indicatorView.stopAnimating()
	}

	@objc
	func pickerController() {
		indicatorView.startAnimating()
		imagePicker.delegate = self
		self.present(imagePicker, animated: true, completion: nil)
	}
}

// MARK: - Data pass
extension EditNoteViewController {
	@objc
	func saveTapped() {
		if customView.dataCompleted() {
			guard let image = customView.imageButton.imageView!.image else {
				return
			}
			delegate.addText(data: customView.textView.text, image: image)
			navigationController?.popViewController(animated: true)
		}
	}
}
