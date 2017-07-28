//
//  SignupVC.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController,UITextFieldDelegate , sigupDelegate{
    
    
    @IBOutlet var signupVM: SignUpViewModel!
    @IBOutlet var emailTextFieldView: UITextField!
    @IBOutlet var passTextFieldView: UITextField!
    @IBOutlet var cPassTextFieldView: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var signupActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var lowerConstraint: NSLayoutConstraint!
    @IBOutlet var activityControllerConstraint: NSLayoutConstraint!
    @IBOutlet var profileSetupButton: UIButton!
    @IBOutlet var alreadyHaveAccountButton: UIButton!
    
    /*++++++++++++++++++++++++++++++++++Class Functions++++++++++++++++++++++*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupVM.delegate = self
        signupButton.isEnabled = false
        addTargets()
        
    }
    
    // add all notifications
    func addTargets(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        signupActivityIndicator.hide()
        cPassTextFieldView.addTarget(self, action: #selector(self.activateSignupButton), for: .editingChanged)
        passTextFieldView.addTarget(self, action: #selector(self.activateSignupButton), for: .editingChanged)
        emailTextFieldView.addTarget(self, action: #selector(self.activateSignupButton), for: .editingChanged)
    }
    
    
    
    /* +++++++++++++++++++++++++++++++++++++++++ delegate functions ++++++++++++++++++++++++++++++*/
    
    
    // fireup once the login is complete
    func signUpComplete(user: FIRUser) {
        self.signupActivityIndicator.hide()
        self.signupActivityIndicator.stopAnimating()
        self.informationLabel.text = self.signupVM.welcomeLabelText
        let alert2 = UIAlertController(withAlertTitle:"welcome Onboard",msg:nil , ActionTitle:"OK"){(action) in
            self.showProfilePage()
        }
        self.present(WithAnimation: alert2)
    }
    
    
    
    // handles error onces happened while communicating with server
    func errorHandler(error: Error?) {
        self.showAlert(msg:error?.localizedDescription, action: "Try Again!")
        self.signupActivityIndicator.hide()
        self.signupActivityIndicator.stopAnimating()
        self.informationLabel.text = self.signupVM.tryAgain
        return
    }
    
    /*++++++++++++++++++++++++++++++++++animation logic ++++++++++++++++++++++*/
    
    
    
    // provide logic to move to next textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextFieldView{
            passTextFieldView.becomeFirstResponder()
        }else if textField == passTextFieldView{
            cPassTextFieldView.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            scrollView.setContentOffset(signupVM.initialPoint, animated: true)
        }
        return true
    }
    
    
    
    // get keyboard height
    func getKeyboardHeight(notification:Notification) -> CGFloat{
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFram:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFram.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        return keyboardHeight
        
    }
    
    
    
    // move scrollview according to keyboard appear
    func keyboardWillShow(notification : Notification){
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardHeight = getKeyboardHeight(notification:notification)
        print(keyboardHeight)
        let animationDuration = userInfo.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval
        
        let svHeight = scrollView.frame.height
        if svHeight <= 600 {
            scrollView.setContentOffset(signupVM.movedPoint,animated:true)
            UIView.animate(withDuration: animationDuration ) {
                self.profileSetupButton.isHidden = true
                self.activityControllerConstraint.constant = 5
                self.lowerConstraint.constant = keyboardHeight - 75
            }
        }else{
            self.lowerConstraint.constant = keyboardHeight + 5
            UIView.animate(withDuration: animationDuration , delay: 0.0 , options: UIViewAnimationOptions.curveEaseInOut, animations:  {
                self.profileSetupButton.isHidden = true
                self.alreadyHaveAccountButton.layoutIfNeeded()
            })
        }
    }
    
    
    
    // move screen according to keyboard hide
    func keyboardWillHide(notification: Notification){
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let animationDuration = userInfo.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval
        
        let svHeight = scrollView.frame.height
        if svHeight <= 600 {
            UIView.animate(withDuration: animationDuration) {
                self.profileSetupButton.isHidden = true
                self.activityControllerConstraint.constant = 20
                self.lowerConstraint.constant = 20
            }
        }else{
            self.lowerConstraint.constant = 20
            UIView.animate(withDuration: animationDuration , delay: 0.0 , options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.profileSetupButton.isHidden = true
                self.alreadyHaveAccountButton.layoutIfNeeded()
            })
            
        }
        scrollView.setContentOffset(signupVM.initialPoint, animated: true)
        print("keyboard Hiding")
    }
    
    
    
    // activate signUp Button once all textFields are filled
    func activateSignupButton(){
        if emailTextFieldView.text != "" && passTextFieldView.text != "" && cPassTextFieldView.text != "" {
            signupButton.isEnabled = true
        }else{
            signupButton.isEnabled = false
        }
    }
    
    
    
    // resign keyboard from all textFields
    func resignTextFieldsRespondents(){
        emailTextFieldView.resignFirstResponder()
        passTextFieldView.resignFirstResponder()
        cPassTextFieldView.resignFirstResponder()
    }
    
    /*++++++++++++++++++++++++++++++++++Actions ++++++++++++++++++++++*/
    
    
    // call signup action
    @IBAction func signupAction(_ sender: Any) {
        if passTextFieldView.text == cPassTextFieldView.text{
            signupActivityIndicator.startAnimating()
            signupActivityIndicator.show()
            resignTextFieldsRespondents()
            informationLabel.text = signupVM.activeSignUpAttemptLabelText
            signupVM.delegate = self
            signupVM.createUser(withEmail: emailTextFieldView.text!, password: passTextFieldView.text!)
        }else{
            showAlert(msg: "Your Need To Confirm Password", action: nil)
        }
    }
    
    
    
    // recognize tap on scrollview and resign all keyboards
    @IBAction func tapGestureOnView(_ sender: Any) {
        resignTextFieldsRespondents()
        scrollView.setContentOffset(signupVM.initialPoint, animated: true)
    }
    
    
    
    // take back to login page
    @IBAction func rewindtoLogin(_ sender: Any) {
        resignTextFieldsRespondents()
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    
    
    /*++++++++++++++++++++++++++++++++++segue ++++++++++++++++++++++*/
    
    
    // segue to this page
    @IBAction func rewindSegue(segue:UIStoryboardSegue){
        resignTextFieldsRespondents()
        performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    
    
    // show profilepage
    func showProfilePage(){
        present(withStoryBoardID: signupVM.profilePageStoryBoardId, animation: true)
    }
    
    
    /*++++++++++++++++++++++++++++++++++alert logic ++++++++++++++++++++++*/
    
    
    // alert functions
    func showAlert(msg:String!, action: String?){
        let alert:UIAlertController!
        if let act = action{
            alert = UIAlertController(msg:msg,action:act)
        }
        else{
            alert = UIAlertController(okaction:msg)
        }
        
        self.present(WithAnimation: alert)
        
    }
}


