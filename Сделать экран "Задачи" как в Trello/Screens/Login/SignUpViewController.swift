
//
//  SignUpViewController.swift
//  AppStructure
//
//  Created by XCodeClub on 2019-11-08.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // text
        let descriptionTextView = UITextView.system(with: "Извините, данная функция сейчас недоступна." +
                                                                "\n\n\n" + "Зарегистрируйтесь через сайт.")
        descriptionTextView.center = view.center
        view.addSubview(descriptionTextView)
    }
    
}
