//
//  IndividualPlayerTableViewCell.swift
//  Venbot
//
//  Created by Rob Wyant on 8/14/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//

import UIKit

class IndividualPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var transactionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
