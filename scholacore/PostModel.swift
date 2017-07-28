//
//  PostModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 30/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase

protocol FbPostModelDelegate:class{
    func didFinishedAddingPost()
    func uploadProgress(progressFraction:CGFloat)
    func errorEncountered(error:String)
}

class FBPostModel:NSObject{
    let storagePostRef = FIRStorage.storage().reference().child("PostImages")
    let postRef = FIRDatabase.database().reference().child("Posts")
    weak var delegate: FbPostModelDelegate?
    var Content:String!
    var userID:String!
    var PostImageURL:String!
    var imageAspectRatio:CGFloat!
    
    func addPost(){
        self.userID = FIRAuth.auth()?.currentUser?.uid
        guard let userName = getUserName() else{
        self.delegate?.errorEncountered(error: "User Information Not Found")
        return
        }
        let value:NSDictionary = ["UserId": self.userID!, "Content" : Content , "Time" : FIRServerValue.timestamp(),"UserName": userName , "PostImageURL" : PostImageURL ,"aspectRatio" : imageAspectRatio]
        postRef.childByAutoId().setValue(value){(error,fbDatabaseRef) in
            if let err = error{
                self.delegate?.errorEncountered(error: err.localizedDescription)
                return
            }
            self.delegate?.didFinishedAddingPost()
        }
        
    
    }
    
    func uploadPostImage(imageData:Data){
        if FIRAuth.auth()?.currentUser != nil {
            let uuid = NSUUID().uuidString
       let uploadTask =  storagePostRef.child("\(uuid).jpg").put(imageData as Data, metadata: nil, completion: { (metaData, error) in
            if let  err = error{
            self.delegate?.errorEncountered(error: err.localizedDescription)
            }
        if let ImageURl = metaData?.downloadURL()?.absoluteString{
            self.PostImageURL = ImageURl
            self.addPost()
        }})
            
        uploadTask.observe(.progress){ (snapShot) in
                guard let progress = snapShot.progress else {return}
        self.delegate?.uploadProgress(progressFraction: CGFloat(Float(progress.fractionCompleted)))
        }
            
        }}
    
    func getUserName() -> String?{
        if let userInfo = UserDefaults.standard.dictionary(forKey: "userInfo"){
        return userInfo["username"] as? String
        }
        
        return nil
     
    }
    
    
    
}
