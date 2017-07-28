//
//  signupViewModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import Foundation
import UIKit
import Firebase

protocol sigupDelegate:class{
    
    func signUpComplete(user:FIRUser)
    func errorHandler(error: Error?)
    
}

class SignUpViewModel:NSObject{
    let initialPoint = CGPoint(x: 0 , y: 0)
    let movedPoint = CGPoint(x: 0 , y: 70)
    let activeSignUpAttemptLabelText = "Signing you up into our system"
    let welcomeLabelText = "WELCOME TO SCHOLACORE"
    let tryAgain = "Try Again !"
    let profilePageStoryBoardId = "ProfileSetupPageView"
    
    weak var delegate:sigupDelegate?
    
    func createUser(withEmail email: String , password: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {( user, error) in
            if error != nil {
                self.delegate?.errorHandler(error: error)
                return
            }
            self.delegate?.signUpComplete(user: user!)
        })
        
    }
}
