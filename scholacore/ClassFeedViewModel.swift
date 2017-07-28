//
//  ClassFeedViewModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import Foundation
import Firebase
import SDWebImage

protocol ClassFeedDelegate: class{
    
    func didFinishDownloadingInitialPosts(initialPosts:[Post])
    func didFinishedDownloadingnewPost(newPost:Post)
    func didFinishDownLoadingMorePosts(morePosts:[Post])
}
class ClassFeedModel:NSObject{
    let databaseRef = FIRDatabase.database().reference()// posts
    var posts = [Post]()
    var currentKey:String!
    var lastPostLoadedKey:String!
    
    weak var delegate:ClassFeedDelegate?
    
    func downloadPosts(){
        
        databaseRef.child("Posts").queryOrderedByKey().queryLimited(toLast: 10).observe(.value, with: { (snapShot) in
            let first = snapShot.children.allObjects.first as! FIRDataSnapshot
            let last = snapShot.children.allObjects.last as! FIRDataSnapshot
            guard snapShot.childrenCount > 0 else {
                return
            }
            
            var i = 0
            if self.posts.isEmpty{
                for snap in snapShot.children.allObjects as! [FIRDataSnapshot]{
                    
                    let post = self.newPost(snap:snap)
                    self.posts.insert(post, at: 0)
                    i += 1
                    print("\(i) all posts download ")
                }
                self.delegate?.didFinishDownloadingInitialPosts(initialPosts: self.posts)
            }else{
                var j = 0
                for snap in snapShot.children.allObjects as! [FIRDataSnapshot]{
                    let post = self.newPost(snap:snap)
                    if self.posts.index(of: post) == nil{
                        j += 1
                        self.posts.insert(post, at: 0)
                        self.delegate?.didFinishedDownloadingnewPost(newPost: post)
                        print("\(j) is new post downloaded ")
                    }
                }
                
            }
            self.currentKey = first.key
            self.lastPostLoadedKey = last.key
        })
        
        
        
        /*databaseRef.child("Posts").queryOrderedByKey().queryLimited(toLast: 1).observe(.childAdded, with: { (snapShot) in
         
         if self.lastPostLoadedKey != snapShot.key{
         let post = self.newPost(snap:snapShot)
         self.delegate?.didFinishedDownloadingnewPost(newPost: post)
         self.lastPostLoadedKey = snapShot.key
         }
         
         })*/
        
    }
    
    
    func downloadMorePosts(){
        if currentKey == nil {
            downloadMorePosts()
        }else{
            databaseRef.child("Posts").queryOrderedByKey().queryEnding(atValue: currentKey).queryLimited(toLast: 6).observeSingleEvent(of: .value, with: { (snapShot) in
                var morePosts = [Post]()
                let first = snapShot.children.allObjects.first as? FIRDataSnapshot
                if snapShot.childrenCount > 0 {
                    
                    for snap in snapShot.children.allObjects as! [FIRDataSnapshot]{
                        if self.currentKey != snap.key{
                            let post = self.newPost(snap: snap)
                            morePosts.insert(post, at: 0)
                        }
                    }
                }
                self.currentKey = first?.key
                self.delegate?.didFinishDownLoadingMorePosts(morePosts: morePosts)
            })
            
        }
    }
    
    
    func newPost(snap:FIRDataSnapshot) -> Post{
        let child = snap.value as! NSDictionary
        let post = Post()
        post.postId = snap.key
        post.content = child["Content"] as! String
        post.UserID = child["UserId"] as! String
        post.postImageURL = child["PostImageURL"] as! String
        post.UserName = child["UserName"] as! String
        post.intTime = child["Time"] as! Int
        post.Time = {
            let time = child["Time"] as? TimeInterval
            let date = NSDate(timeIntervalSince1970:time!/1000.0)
            let dateformatter = DateFormatter()
            dateformatter.string(from: date as Date)
            dateformatter.dateStyle = .full
            return dateformatter.string(from: date as Date)}()
        let imageview =  UIImageView()
        imageview.sd_setImage(with: URL(string:post.postImageURL))
        post.postImage = imageview.image
        return post
    }
    
}

