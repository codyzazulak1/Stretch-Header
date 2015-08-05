//
//  NewsItemTableViewCell.swift
//  Stretch My Header
//
//  Created by Cody Zazulak on 2015-08-04.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var headlineLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
