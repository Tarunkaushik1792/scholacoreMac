//
//  headerCollectionViewCell.swift
//  scholacore
//
//  Created by Tarun kaushik on 21/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Reusable

class headerCollectionViewCell: UICollectionViewCell ,NibReusable{
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var timeOfPostingLabel: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(postInfo: Post) {
        self.userNameLabel.text = postInfo.UserName
        self.timeOfPostingLabel.text = postInfo.Time
    }

}
