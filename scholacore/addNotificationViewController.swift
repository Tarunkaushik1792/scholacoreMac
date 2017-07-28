//
//  addNotificationViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Firebase

class addNotificationViewController: UIViewController ,UITextViewDelegate,NotificationDelegate{
    
    @IBOutlet var NotificationVM: NotificationViewModel!
    @IBOutlet var notificationTextView:UITextView!
    var dbRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title = "ADD NOTIFICATION"
        notificationTextView.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "add your notification here "{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    
    
    @IBAction func sendNotificationAction(_ sender: Any) {
        guard FIRAuth.auth()?.currentUser?.uid != nil else{
            let profileVm = userProfileModel()
            profileVm.logout()
            performSegue(withIdentifier: "unwindToLogin", sender: self)
            return
        }
        
        guard let message = notificationTextView.text , message != "" else {
            showAlert(msg: "Please enter Some message")
            return
        }
        NotificationVM.delegate = self
        NotificationVM.addNotification(message: message)
        
    }
    
    func didFinishedSendingNotification() {
        showAlert(msg: "Notfications is sent")
    }
    
    func didEncounterError(error: String!) {
        showAlert(msg: error)
    }
    func showAlert(msg:String!){
        let alert = UIAlertController(okaction:msg)
        self.present(WithAnimation: alert)
    }
    
    
}
