//
//  NotificationsViewModel.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol  NotificationDelegate:class{
    func didFinishedSendingNotification()
    func didFinishedDownloadingInitialNotifications(notifications : [FBNotification])
    func didFinishedDownloaingMoreNotifications(notifications:[FBNotification])
    func didFinishedDownloadingNewNotification(notification:FBNotification)
    func didEncounterError(error:String!)
}

extension NotificationDelegate{
    func didFinishedSendingNotification(){}
    func didFinishedDownloadingInitialNotifications(notifications : [FBNotification]){}
    func didFinishedDownloaingMoreNotifications(notifications:[FBNotification]){}
    func didFinishedDownloadingNewNotification(notification:FBNotification){}
    func didEncounterError(error:String!){}
}

class NotificationViewModel:NSObject{
    
    var fbNotifications = [FBNotification]()
    var testArray = [FBNotification]()
    var currentKey:String?
    var lastPostkey:String?
    var noticRef = FIRDatabase.database().reference().child("Notification")// notifications
    
    weak var delegate:NotificationDelegate?
    
    func addNotification(message : String!){
        guard FIRAuth.auth()?.currentUser?.uid != nil else{
            return
        }
        let value:NSDictionary = ["userName":"test","Message":message,"Time":FIRServerValue.timestamp()]
        noticRef.childByAutoId().setValue(value){
            (error , firBbRef) in
            if let err = error {
                print(err.localizedDescription)
                self.delegate?.didEncounterError(error: err.localizedDescription)
            }
            self.delegate?.didFinishedSendingNotification()
        }
    }
    
    func downloadNotifications(){
        var handler:UInt = 0
        handler = noticRef.queryOrderedByKey().queryLimited(toLast: 10).observe(FIRDataEventType.value, with: { (SnapShot) in
            
            guard  SnapShot.childrenCount > 0 else {
                return
            }
            
            let last = SnapShot.children.allObjects.last as! FIRDataSnapshot
            let first = SnapShot.children.allObjects.first as! FIRDataSnapshot
            if self.fbNotifications.isEmpty {
                for snap in SnapShot.children.allObjects as! [FIRDataSnapshot]{
                    print(snap)
                    let notice = self.notification(snap)
                    self.fbNotifications.insert(notice, at: 0)
                }
                self.delegate?.didFinishedDownloadingInitialNotifications(notifications: self.fbNotifications)
            }else{
                for snap in SnapShot.children.allObjects as! [FIRDataSnapshot]{
                    
                    let notice = self.notification(snap)
                    if self.fbNotifications.index(of: notice) == nil {
                        self.fbNotifications.insert(notice, at: 0)
                        self.delegate?.didFinishedDownloadingNewNotification(notification: notice)
                    }
                    
                }
                
            }
            self.lastPostkey = last.key
            self.currentKey = first.key
        //self.noticRef.removeObserver(withHandle: handler)
        })
    
    }
    
    func newDownloadMethod(){
        noticRef.queryOrderedByKey().queryLimited(toLast: 1).observe(.childAdded, with: { (snapShot) in
            print(snapShot)
            if self.lastPostkey != snapShot.key{
             let notice = self.notification(snapShot)
             self.delegate?.didFinishedDownloadingNewNotification(notification: notice)
            self.lastPostkey = snapShot.key
            }
          
        })
    }
    
    func downloadMoreNotifications(){
        noticRef.queryOrderedByKey().queryEnding(atValue: currentKey).queryLimited(toLast: 6).observeSingleEvent(of: .value, with: { (SnapShot) in
            guard SnapShot.childrenCount > 0 else{
                return
            }
            var moreNotices = [FBNotification]()
            for snap in SnapShot.children.allObjects as! [FIRDataSnapshot]{
                let notice = self.notification(snap)
                moreNotices.insert(notice, at: 0)
            }
            self.delegate?.didFinishedDownloaingMoreNotifications(notifications: moreNotices)
            let first = SnapShot.children.allObjects.first as! FIRDataSnapshot
            self.currentKey = first.key
        })
        
    }
    
    func notification(_ snap:FIRDataSnapshot) -> FBNotification{
        let notice = FBNotification()
        notice.key = snap.key
        let child = snap.value as! NSDictionary
        notice.message = child["Message"] as! String
        notice.TimeStamp = child["Time"] as! Int
        notice.userName = child["userName"] as! String
        return notice
    }
    
}

