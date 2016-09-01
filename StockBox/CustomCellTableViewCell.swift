//
//  CustomCellTableViewCell.swift
//  StockBox
//
//  Created by Michael Manisa on 8/31/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var stockNumberLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var imageThumbView: UIImageView!
    
    
    
    
}
