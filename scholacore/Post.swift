//
//  Post.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

class Post{
    var postId:String!
    var content: String!
    var UserID: String!
    var Time: String!
    var intTime: Int!
    var postImageURL:String!
    var UserName: String!
    var postImage:UIImage?
    var userImage:UIImage?
    var postType:Int?
    var fileName:String?
    var fileUrl:String!
    var fileType:String!
    var imageAspectRatio:CGFloat?
}

extension Post:Equatable{
    static public func ==(rhs:Post , lhs:Post)-> Bool{
        return rhs.postId == lhs.postId
    }
}

extension Post:IGListDiffable{
    
    public func diffIdentifier() -> NSObjectProtocol {
        return postId! as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Post else{
            return false
        }
        
        if self.postId != object.postId || UserName != object.UserName{
            return false}
        
        return self == object
    }
}

