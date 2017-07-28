//
//  SubjectViewModel.swift
//  scholacore
//
//  Created by Himanshu Kaushik on 25/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase
protocol FIRSubjectDelegate:class {
    func errorEncountered(error:String)
    func didFinishedAddingSubjectToDataBase(subject:Subject)
    func didFinishedUpdatingSubject()
    func didFinishedDownloadingSubjectList(Subjects:[Subject])
    func didFinishedRemovingSubject(atIndexPath indexPath:IndexPath)
}

class SubjectViewModel:NSObject{
    let subjectDbRef = FIRDatabase.database().reference().child("Subjects")

    weak var delegate:FIRSubjectDelegate?
    func addSubject(subject : Subject){
        var sub = subject
        let uniqureID = NSUUID().uuidString
        let values = ["Name":subject.name,"ColorCode":subject.colorCode as Any,"References":subject.refrence as Any,"subjectID":uniqureID] as [String : Any]
        subjectDbRef.childByAutoId().setValue(values){(error,dbRef) in
            if error != nil {
                self.delegate?.errorEncountered(error: (error?.localizedDescription)!)
                return
            }
        }
        sub.subjectID = uniqureID
        self.delegate?.didFinishedAddingSubjectToDataBase(subject:sub)
    }
    
    func updateSubject(subject:Subject , key:String){
        let values = ["Name":subject.name,"ColorCode":subject.colorCode!,"References":subject.refrence!] as [String : Any]
        subjectDbRef.child(key).updateChildValues(values){(error,dbRef) in
            if error != nil {
                self.delegate?.errorEncountered(error: (error?.localizedDescription)!)
                return
            }
            self.delegate?.didFinishedUpdatingSubject()
        }
    }
    
    func loadSubjectList(){
         var subject = Subject()
        subjectDbRef.observe(.value , with: {(SnapShot) in
            guard SnapShot.childrenCount > 0 else {return}
            var subjects:[Subject] = []
            for snap in SnapShot.children.allObjects as! [FIRDataSnapshot]{
                let child = snap.value as! NSDictionary
                subject.name = child["Name"] as! String
                subject.colorCode = child["ColorCode"] as? Int
                subject.refrence = (child["References"] as! String)
                subject.subjectID = child["subjectID"] as! String
                subjects.append(subject)
            }
            self.delegate?.didFinishedDownloadingSubjectList(Subjects: subjects)
            SnapShot.ref.removeAllObservers()
        })
    }
    
    func deleteSubject(key:String,indexPath:IndexPath){
        subjectDbRef.queryOrdered(byChild: "subjectID").queryEqual(toValue: key).observe(.childAdded, with:  { (snapShot) in
            snapShot.ref.removeValue(){(error,reference) in
                if error != nil {
                    self.delegate?.errorEncountered(error: (error?.localizedDescription)!)
                    return
                }
                self.delegate?.didFinishedRemovingSubject(atIndexPath: indexPath)
            }
        })
    }
    
}
