//
//  editTableViewCell.swift
//  scholacore
//
//  Created by Himanshu Kaushik on 22/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class editTableViewCell: UITableViewCell {
    
    @IBOutlet var editButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var subjectNameLabel: UILabel!
    var lectureINfo:lecture?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.layer.cornerRadius = 5
        editButton.clipsToBounds = true
        editButton.layer.borderColor = UIColor.blue.cgColor
        editButton.layer.borderWidth = 1
        let frame = editButton.frame
        editButton.frame = CGRect(x:frame.minX , y: frame.minY , width: 0 , height: frame.size.height)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.editButton.frame = frame
        })
        // Initialization code
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    func setup(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let startTime = dateFormatter.string(from: (lectureINfo?.StartTime)!)
        let endTime = dateFormatter.string(from: (lectureINfo?.finishTime)!)
        timeLabel.text = " \(startTime) \n TO \n \(endTime)"
    }

}
