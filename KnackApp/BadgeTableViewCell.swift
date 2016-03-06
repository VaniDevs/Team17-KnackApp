//
//  BadgeTableViewCell.swift
//  KnackApp
//
//  Created by Joohan Oh on 2016-03-05.
//  Copyright © 2016 Sebastian Valdivia. All rights reserved.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var badgeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
