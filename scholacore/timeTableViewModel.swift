//
//  timeTableViewModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 16/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class timeTableViewModel: NSObject {
    let timeTableRef = FIRDatabase.database().reference().child("TimeTable")
    let lecturesRef = FIRDatabase.database().reference().child("Lectures")
    var classes:[String] = []
    func createTimeTable(key:String){
        classes.append(key)
        timeTableRef.child("MBAIIIA").child("Monday").setValue(classes){(error,ref) in
            if error != nil {return}
            print(ref.parent?.key)
        }
    }
    
    func createLecture(){
        for _ in 1...5{
        let val = ["subject":"POM" , "Hour" : 1 , "Minute": 45 ,"Duration":55 , "teacher":"Name of teacher"] as [String : Any]
        lecturesRef.childByAutoId().setValue(val){
           (error,fbref) in
            if error != nil {
               print(error?.localizedDescription)
            }
            
                self.createTimeTable(key: fbref.key)
            
        }
        }
        
    }
    
    func downloadTimeTable(){
        
    }
    func changeTimeTable(){}
}
