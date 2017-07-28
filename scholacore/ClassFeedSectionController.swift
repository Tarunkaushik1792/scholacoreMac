//
//  ClassFeedSectionController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import IGListKit
import SDWebImage
import Reusable

class ClassFeedSectionController: IGListSectionController {
    var post:Post?
    var firstFeed : UIViewController?
    override init() {
        super.init()
    }
}

extension ClassFeedSectionController:IGListSectionType{
    
    
    func numberOfItems() -> Int {
        return 4
    }

    
    func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext , let post = post else{return .zero}
        let width = context.containerSize.width
        if post.postType != nil{
            return CGSize(width:width,height:150)
        }else if index == 3{
            let height = contentCellHeight(index)
            print("height of cell \(height)")
            return CGSize(width:width,height:height)
        }else if index == 0 {
            return CGSize(width : width , height: 60)
        }else if index == 2{
            return CGSize(width: width , height : 40)
        }
        let photoheight = photoCellHeight()
        print("photo height \(photoheight) and width of cell is 375")
        if photoheight <= width{
            let margin = (width - photoheight) * 0.5
            return CGSize(width:width,height: photoheight)
        }
        return CGSize(width:width , height: photoheight)
    }
    
    
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        if post?.postType == nil && index == 1{
            return postCollectionCell(index)
        }else if index == 3{
            return contentCollectionCell(index)
        }else if index == 0 {
          return headerCell(index)
        }else if index == 2 {
            return postMenuCellAt(index)
        }else{
            return fileCollectionCell(index)
            
        }
    }
    
    func headerCell(_ index:Int)-> UICollectionViewCell{
    let cell = collectionContext?.dequeueReusableCell(withNibName: headerCollectionViewCell.reuseIdentifier, bundle: .main , for: self, at: index) as? headerCollectionViewCell
        if let post = self.post{
        cell?.setup(postInfo: post)
        }
    return cell!
    }
    
    
    func postMenuCellAt(_ index:Int) -> UICollectionViewCell{
        let cell = collectionContext?.dequeueReusableCell(withNibName: postMenuCell.reuseIdentifier , bundle: .main, for: self, at: index) as! postMenuCell
        return cell
    }
    
    func postCollectionCell(_ index:Int)-> UICollectionViewCell{
        let cell = collectionContext?.dequeueReusableCell(withNibName: PostCollectionCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! PostCollectionCell
       
        let width = collectionContext?.containerSize.width
        if let post = self.post{
            cell.setup(postInfo: post , width: width)
        }
        if let first = firstFeed as? FirstViewController{
            cell.delegate = first
        }else{
            cell.delegate = firstFeed as! ClassFeedViewController
        }
        cell.currentView = firstFeed
        return cell
    }
    
    func contentCollectionCell(_ index:Int) -> UICollectionViewCell{
    let cell = collectionContext?.dequeueReusableCell(withNibName: ContentCollectionViewCell.reuseIdentifier , bundle: Bundle.main, for: self, at: index) as! ContentCollectionViewCell
        if let post = self.post{
            cell.contentTextView.text = post.content
            cell.dateLabel.text = post.Time
           // var frame = cell.contentTextView.frame
            //frame.size.height = cell.contentTextView.contentSize.height
            //cell.contentTextView.frame = frame
           // cell.frame.size.height = frame.height
        }
     return cell
    }
    
    func contentCellHeight(_ index:Int)-> CGFloat{
        let textView :UITextView = UITextView(frame:CGRect(x:0,y:0,width:(self.viewController?.view.frame.size.width)! - 40 , height: 600))
        textView.font = .systemFont(ofSize: 17)
        textView.text = post?.content
        var frame = textView.frame
        frame.size.height = textView.contentSize.height
        print("content cell height \(textView.contentSize.height)")
        let height = textView.contentSize.height
        if textView.text == ""{
        return 40
        }else{
        return height + 20
        }
    }
    
    func photoCellHeight() -> CGFloat{
        guard let context = collectionContext , let post = post else{return 0}
        let width = context.containerSize.width
        let height = width / (post.imageAspectRatio)!
        return height
    }
    
    
    func fileCollectionCell(_ index:Int) -> UICollectionViewCell{
        let cell = collectionContext?.dequeueReusableCell(withNibName: FileCollectionViewCell.reuseIdentifier , bundle: Bundle.main, for: self, at: index) as! FileCollectionViewCell
        if let post = self.post{
            cell.setUp(post:post)
        }
        return cell
    }
    
    
    func didSelectItem(at index: Int) {
        if post?.postType != nil{
            let url = "https://firebasestorage.googleapis.com/v0/b/myfirstfirebaseapp-3f8ac.appspot.com/o/files%2FJD.pdf?alt=media&token=f4c43974-5716-48f1-a150-e203c4fd71fe"
            let webview = UIWebView(frame: (self.viewController?.view.frame)!)
            webview.scalesPageToFit = true
            let urlRequest = URLRequest(url: NSURL(string: url)! as URL)
            webview.loadRequest(urlRequest as URLRequest)
            webview.isUserInteractionEnabled = true
            let docView = UIViewController()
            docView.view.addSubview(webview)
            docView.title = "Notice"
            firstFeed?.navigationController?.pushViewController(docView, animated: true)
        }
        if index == 3 {
            let sb = UIStoryboard(name: "Main" , bundle : nil)
            let vc = sb.instantiateViewController(withIdentifier: "postDetailNav") as! UINavigationController
            let target = vc.topViewController as! postDetailVC
            target.post = post
           firstFeed?.navigationController?.pushViewController(target, animated: true)
           //firstFeed?.present(WithAnimation: vc)
        }
        
    }
    
    func didUpdate(to object: Any) {
        post = object as? Post
    }
    
}
