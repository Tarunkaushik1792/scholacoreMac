//
//  PostCollectionCell.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

protocol postAble {
    func setup(postInfo : Post , width: CGFloat!)
}

protocol CellActionDelegate:class {
    func didTapedOnImageView(postImageView:UIImageView , View:UIView)
}

class PostCollectionCell: UICollectionViewCell,NibReusable,postAble {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    var currentView:UIViewController? = nil
    
    weak var delegate:CellActionDelegate?
    
    @IBOutlet var postImageView: UIImageView! = { let imageView  = UIImageView()
        imageView.isUserInteractionEnabled = true
       // imageView.addGestureRecognizer(UITapGestureRecognizer(target:self , action : #selector(PostCollectionCell.animation)))
        return imageView
    }()
    
 //   @IBOutlet var contentLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postImageView.isUserInteractionEnabled = true
        postImageView.addGestureRecognizer(UITapGestureRecognizer(target:self , action : #selector(self.animation)))
    }
    
    func animation(){
        let vc = storyboard.instantiateViewController(withIdentifier: "detailNav") as! UINavigationController
        let target = vc.topViewController as! DetailViewController
        target.postImage = self.postImageView.image
        currentView?.present(WithAnimation: vc)
        //delegate?.didTapedOnImageView(postImageView: postImageView, View: self)
    }
    
    func setup(postInfo: Post , width: CGFloat!) {
       
        if let imageURL = postInfo.postImageURL{
            self.postImageView.sd_setImage(with: URL(string: imageURL),placeholderImage:#imageLiteral(resourceName: "Userimage"))
        }
        let height = width/postInfo.imageAspectRatio!
        print(postImageView.frame)
        if height <= width{
            let margin = (width - height) * 0.5
            self.postImageView.frame = CGRect(x:0,y:0,width:width , height : height)
        }else{
            self.postImageView.frame = CGRect(x:0,y:0,width:width , height : height)
        }
        print("updated \(postImageView.frame)")
    }
    
    @IBAction func extraMenuAction(_ sender: Any) {
    }
    
    
    
}
