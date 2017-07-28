//
//  ContentCollectionViewCell.swift
//  scholacore
//
//  Created by Tarun kaushik on 18/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Reusable

class ContentCollectionViewCell: UICollectionViewCell,NibReusable {
 
    @IBOutlet var contentTextView: UITextView!
    var textView:UITextView!
    @IBOutlet var dateLabel: UILabel!
    //static func cellSize(width: CGFloat, text: String) -> CGSize {
     //   return
   // }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setup(post:Post){
        contentTextView.text = post.content
        var frame = contentTextView.frame
        if post.content == "" {
            frame.size.height = 40
        }else{
            frame.size.height = contentTextView.contentSize.height + 40
        }
        contentTextView.frame = frame
        self.frame = frame
    }

}
