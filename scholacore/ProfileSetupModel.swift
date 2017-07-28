//
//  ProfileSetupModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol ProfileSetupDelegate:class {
    /** This method is called when the user profile information is successfully uploaded into the firebase database
     - Parameter databaseReference : it returns reference to the location where change is made in firebase database
     */
    func didFinishedUploadingUserInfo(databaseRefrence : FIRDatabaseReference?)
    /**  This method return error when attempts are made to do some task on firbase
     - Parameter error: error return the type of error which has happend*/
    func errorHandler(error:Error?)
    /** This method is called when the user profile image is successfully uploaded to the firebase storage
     - Parameter metaData : It returns the metaData of the image uploaded
     */
    func didFinishedUploadingUserProfileImage(metadata: FIRStorageMetadata?)
}

extension ProfileSetupDelegate{
    
    func didFinishedUploadingUserInfo(databaseRefrence : FIRDatabaseReference?){
    }
    func didFinishedUploadingUserProfileImage(metadata: FIRStorageMetadata?){
    }
}

class ProfileSetupModel:NSObject{
    
    
    let databaseRef = FIRDatabase.database().reference().child("Profiles") // profiles
    let storageRef = FIRStorage.storage().reference().child("ProfileImages")// profileimages
    weak var delegate:ProfileSetupDelegate?
    
    
    func saveProfileDetials(uName:String , erpId:String , course : String){
        if let userId = FIRAuth.auth()?.currentUser?.uid{
            
            let userInfo:NSDictionary = ["username" : uName , "userRoll" : erpId , "course" : course]
            databaseRef.child(userId).setValue(userInfo){(error,dBref) in
                if error != nil {
                    self.delegate?.errorHandler(error: error)
                    return
                }
                UserDefaults.standard.set(userInfo, forKey: "userInfo")
                self.delegate?.didFinishedUploadingUserInfo(databaseRefrence: dBref)
            }
        }
    }
    
    func saveProfileImage(imageData:Data){
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            
            self.storageRef.child("\(uid).jpg").put(imageData as Data , metadata: nil, completion: { (metaData, error) in
                if error != nil{
                    self.delegate?.errorHandler(error: error)
                    return
                }
                UserDefaults.standard.set(imageData , forKey : "userProfileImage")
                self.delegate?.didFinishedUploadingUserProfileImage(metadata: metaData)
            })
        }
        
    }
}

