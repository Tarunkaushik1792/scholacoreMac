//
//  loginViewModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase

protocol loginDelegate:class{
    func userLoginSuccessFull(user : FIRUser?)
    func didFinisedLoadingUserInfo(userInfo:NSDictionary)
    func userProfileNotFound()
    func errorHandler(error:Error?)
}

extension loginDelegate{
    
    func didFinisedLoadingUserInfo(userInfo:NSDictionary){
        
    }
    
    func userProfileNotFound(){
    }
}

class LoginViewModel:NSObject{
    let preLoginAttemptLabel = "Login To Start"
    let activeLoginAttemptLabel = "Loging in..."
    let postLoginAttemptLabel = "Login Successful"
    let failedLoginAttemptLabel = "Try Again!"
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let emailWarning = "please enter your credentials"
    let passwordWarning = "Password is not correct"
    let initialPoint = CGPoint(x: 0 , y: 0)
    let movedPoint = CGPoint(x: 0 , y: 100)
    //let profileRef = FIRDatabase.database().reference().child("Profiles") // profiles
    
    weak var delegate:loginDelegate?
    
    var homeVC:UIViewController{
        return storyboard.instantiateViewController(withIdentifier: "Home")
    }
    
    var profileVC:UIViewController{
        return storyboard.instantiateViewController(withIdentifier: "ProfilePage")
    }
    
    func checkUserLogedIn(ViewController: UIViewController){
        let view = ViewController as! LogInViewController
        if FIRAuth.auth()?.currentUser != nil {
            view.present(withoutAnimation: self.homeVC)
        }
    }
    
    
    func login(uEmail : String! , uPass : String!){
        FIRAuth.auth()?.signIn(withEmail: uEmail, password: uPass, completion: { (user, error) in
            if error != nil {
                self.delegate?.errorHandler(error: error)
                return
            }
            self.delegate?.userLoginSuccessFull(user: user)
        })
    }
    
    func getUserInfo(){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            FIRDatabase.database().reference().child("Profiles").child(uid).observe(.value, with: { (SnapShot) in
                if SnapShot.childrenCount != 0 {
                    if let child = SnapShot.value as? NSDictionary{
                        let userINfo = User()
                        userINfo.username = child["username"] as? String
                        userINfo.userRoll = child["userRoll"] as? String
                        userINfo.userCourse = child["course"] as? String
                        self.saveDataLocally(user: userINfo)
                    }
                }else{
                    self.delegate?.userProfileNotFound()
                }
                
            })
        }}
    
    func saveDataLocally(user: User){
        guard user.username != nil else{
            return
        }
        
        let userInfo:NSDictionary = ["username": user.username!,"userRoll" : user.userCourse!,"course": user.userCourse!]
        UserDefaults.standard.set(userInfo,forKey:"userInfo")
        self.delegate?.didFinisedLoadingUserInfo(userInfo: userInfo)
    }
    
}

