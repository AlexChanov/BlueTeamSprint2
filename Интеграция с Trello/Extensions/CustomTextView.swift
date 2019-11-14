//
//  CustomTextView.swift
//  AppStructure
//
//  Created by VadimQw  on 12/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

extension UITextView {
    public static func system(with text: String) -> UITextView {
        let textView = UITextView()
        textView.frame.size = CGSize(width: 300, height: 300)
        textView.isScrollEnabled = false
        textView.isEditable = false
        // text
        textView.attributedText = NSMutableAttributedString(string: text,
                                                            attributes: [.font: UIFont.textTitle])
        textView.textAlignment = .center
        return textView
    }
}
