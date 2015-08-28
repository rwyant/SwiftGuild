//
//  PlayersTableViewCell.swift
//  Venbot
//
//  Created by Rob Wyant on 8/13/15.
//  Copyright (c) 2015 Yapper. All rights reserved.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
