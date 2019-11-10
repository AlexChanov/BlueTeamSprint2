//
//  NotesTableViewCell.swift
//  AppStructure
//
//  Created by Алексей ]Чанов on 10/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    public static let reuseId = "notesCell"

    public let notesLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.center = self.contentView.center
        notesLabel.textAlignment = .left
        notesLabel.lineBreakMode = .byWordWrapping
        notesLabel.numberOfLines = 0
        contentView.addSubview(notesLabel)
        notesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive            = true
        notesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive      = true
        notesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive    = true
        notesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        notesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive                 = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
