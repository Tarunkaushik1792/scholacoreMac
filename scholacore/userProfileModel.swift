//
//  userProfileModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol userProfileDelegate:class{
    
    func userProfileInfo(userInfo:User)
    func userProfilePicLoaded(userImage:UIImage)
    func errorHandler(error:Error?)
    func didFinishedSavingUserData()
    
}

class userProfileModel:NSObject {
    let storageRef = FIRStorage.storage().reference().child("ProfileImages")// profileimages
    let dbRef = FIRDatabase.database().reference().child("Profiles") // profiles
    var user = User()
    
    weak var delegate:userProfileDelegate?
    
    var username:String{
        return user.username ?? "set your name"
    }
    var userRoll:String{
        return user.userRoll ??  "set your rollnumber"
    }
    var userCourse:String{
        return user.userCourse ?? "type your course"   }
    
    var userProfileImage:UIImage{
        return userImage
    }
    
    private var userInfo:NSDictionary = [:]
    private var userImage:UIImage!
    
    override init(){
        super.init()
    }
    
    
    func saveUserData(userName:String , userRoll: String , userCourse : String){
        let userInfo:NSDictionary = ["username" : userName , "userRoll" : userRoll , "course" : userCourse]
        uploadToFirebaseDb(userInfo: userInfo)
    }
    
    func saveUserDataLocally(userName:String , userRoll: String , userCourse : String){
        let userInfo:NSDictionary = ["username" : userName , "userRoll" : userRoll , "course" : userCourse]
        UserDefaults.standard.set(userInfo, forKey: "userInfo")
    }
    
    func loadUserData(){
        user.userID = FIRAuth.auth()?.currentUser?.uid
        if let userin = UserDefaults.standard.dictionary(forKey: "userInfo"){
            userInfo = userin as NSDictionary
            user.username = userInfo.value(forKey: "username") as? String
            user.userRoll = userInfo.value(forKey: "userRoll") as? String
            user.userCourse = userInfo.value(forKey: "course") as? String
            self.delegate?.userProfileInfo(userInfo: user)
        }else{
            loadFromFirebaseDb()
        }
    }
    
    func loadFromFirebaseDb(){
        let userId = FIRAuth.auth()?.currentUser?.uid
        print(userId!)
        dbRef.child(userId!).observeSingleEvent(of: .value, with: { (snapShot) in
            if let userSnap = snapShot.value as? NSDictionary{
                self.user.username = userSnap["username"] as? String
                self.user.userRoll = userSnap["userRoll"] as? String
                self.user.userCourse = userSnap["course"] as? String
                self.saveUserDataLocally(userName: self.username  , userRoll: self.userRoll, userCourse: self.userCourse)
                self.delegate?.userProfileInfo(userInfo: self.user)
            }
            
        })
    }
    
    func logout(){
        let uid = FIRAuth.auth()?.currentUser?.uid
        let dbref = FIRDatabase.database().reference().child("notificationTokens")
        if let token = FIRInstanceID.instanceID().token(){
            let values:NSDictionary = ["pushToken": token,"email":FIRAuth.auth()?.currentUser?.email! ?? "none","active":false]
            dbref.child(uid!).setValue(values)
        }
        try? FIRAuth.auth()?.signOut()
        UserDefaults.standard.removeObject(forKey: "userInfo")
        UserDefaults.standard.removeObject(forKey: "userProfileImage")
    }
    
    
    func loadUserImage(){
        if let profileData = UserDefaults.standard.data(forKey: "userProfileImage"){
            userImage = UIImage(data: profileData)
            user.userProfileImage = userImage
            self.delegate?.userProfilePicLoaded(userImage: self.user.userProfileImage!)
        }else{
            if let userId = FIRAuth.auth()?.currentUser?.uid{
                storageRef.child("\(userId).jpg").data(withMaxSize: 1*1024*1024) { (imageData, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "error")
                        self.delegate?.errorHandler(error: error)
                        return
                    }
                    self.user.userProfileImage = UIImage(data: imageData!)
                    UserDefaults.standard.set(imageData, forKey:"userProfileImage")
                    
                    self.delegate?.userProfilePicLoaded(userImage: self.user.userProfileImage!)
                }}
        }
    }
    
    
    func saveUserImage(uImage:UIImage){
        let imageData = UIImageJPEGRepresentation(uImage, 0.5)
        if (user.userID != nil){
            upLoadToFirebaseStorage(Data: imageData!)
        }
    }
    
    
    func upLoadToFirebaseStorage(Data:Data){
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            storageRef.child("\(uid).jpg").put(Data, metadata: nil){(metadata,error) in
                if error != nil {
                    self.delegate?.errorHandler(error: error)
                    return
                }
                UserDefaults.standard.set(Data,forKey: "userProfileImage")
            }
        }
    }
    
    
    func uploadToFirebaseDb(userInfo:NSDictionary){
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            dbRef.child(uid).setValue(userInfo, withCompletionBlock: { (error, dbReference) in
                if error != nil{
                    self.delegate?.errorHandler(error: error)
                }
                UserDefaults.standard.set(userInfo , forKey:"userInfo")
                self.delegate?.didFinishedSavingUserData()
            })
            
        }
        
    }
    
    
    
    
    
    
}

