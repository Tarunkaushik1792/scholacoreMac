//
//  newTableViewCell.swift
//  traffismart
//
//  Created by Tarun kaushik on 09/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class newTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var extraInfoLabel: UILabel!
    @IBOutlet var mainInfoLabel: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
