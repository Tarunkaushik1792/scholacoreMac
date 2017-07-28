//
//  profileSetupViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//
//
//  profileSetupViewController.swift
//  Scholacore
//
//  Created by Tarun kaushik on 28/04/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Firebase

class profileSetupViewController: UIViewController,UITextFieldDelegate, ProfileSetupDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var erpIdTextField: UITextField!
    @IBOutlet var courseTextField: UITextField!
    @IBOutlet var profileSetupVM: ProfileSetupModel!
    @IBOutlet var profileStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    
    
    @IBAction func nextClickedEvent(_ sender: Any) {
        guard let uName = userNameTextField.text , uName != "" else{return }
        
        guard let erpId = erpIdTextField.text , erpId != "" else {return}
        
        guard let course = courseTextField.text , course != "" else{return }
        
        profileSetupVM.delegate = self
        profileSetupVM.saveProfileDetials(uName: uName, erpId: erpId, course: course)
    }
    
    func didFinishedUploadingUserInfo(databaseRefrence: FIRDatabaseReference?) {
        self.slideToDisplayPicPage()
    }
    
    func errorHandler(error: Error?) {
        showAlert(msg: error?.localizedDescription, action: nil)
    }
    
    func slideToDisplayPicPage(){
        let pageViewController = parent as! ProfileSetupPageViewController
        pageViewController.forward();
    }
    
    
    func showAlert(msg:String! , action:String?){
        var alert:UIAlertController!
        if action == nil {
            alert = UIAlertController(okaction:msg)
        }else{
            alert = UIAlertController(msg:msg , action:action)
        }
        
        self.present(WithAnimation: alert)
    }
    
}
