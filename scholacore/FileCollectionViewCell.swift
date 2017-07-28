//
//  FileCollectionViewCell.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Reusable

class FileCollectionViewCell: UICollectionViewCell,NibReusable {
    
    @IBOutlet var fileName: UILabel!
    @IBOutlet var fileIconImageVIew: UIImageView!
    var post:Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(post:Post){
        self.post = post
        self.fileName.text = post.fileName
        switch post.fileType{
        case "pdf":
            fileIconImageVIew.image = #imageLiteral(resourceName: "PDFFILEICON")
        case "doc":
            fileIconImageVIew.image = #imageLiteral(resourceName: "DOC FILE ICON")
        default:
            fileIconImageVIew.image = #imageLiteral(resourceName: "list-simple-7")
            
        }
    }
}
