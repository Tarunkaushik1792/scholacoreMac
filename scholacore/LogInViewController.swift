//
//  LogInViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController , UITextFieldDelegate , loginDelegate{
    
    //===============================Variables========================//
    @IBOutlet var loginVM: LoginViewModel!
    @IBOutlet var logImageTopConstrant: NSLayoutConstraint!
    @IBOutlet var logImage: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    var x:Int!
    var y:Int!
    var point:CGPoint!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loginInfoIndicatorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser != nil && UserDefaults.standard.object(forKey: "userInfo") != nil{
            present(withoutAnimation: loginVM.homeVC)
            return
        }else if FIRAuth.auth()?.currentUser != nil {
        let user = userProfileModel()
            user.logout()
        }
        activityIndicator.stopAnimating()
        loginInfoIndicatorLabel.text = loginVM.preLoginAttemptLabel
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            present(withoutAnimation: loginVM.homeVC)
        }
    }
    
    func userLoginSuccessFull(user: FIRUser?) {
        loginVM.getUserInfo()
    }
    
    func errorHandler(error: Error?) {
        activityIndicator.stopAnimating()
        loginInfoIndicatorLabel.text = loginVM.failedLoginAttemptLabel
        showAlert(msg: (error?.localizedDescription)!, action: "Try Again!")
    }
    
    func didFinisedLoadingUserInfo(userInfo: NSDictionary) {
        activityIndicator.stopAnimating()
        self.loginInfoIndicatorLabel.text = loginVM.postLoginAttemptLabel
        showHome()
    }
    
    func userProfileNotFound() {
        showProfileSetUpPage()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(loginVM.initialPoint, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(loginVM.movedPoint, animated: true)
    }
    
    // when return button touched on the keyboard it goes down
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scrollView.setContentOffset(point, animated: true)
        textField.resignFirstResponder()
        return true
    }
    
    // keyboard lowerdown when tapped on scrollview
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        scrollView.setContentOffset(loginVM.initialPoint, animated: true)
        resignTextFields()
    }
    
    @IBAction func unwindToLogIn(segue: UIStoryboardSegue){
        self.activityIndicator.hide()
        self.loginInfoIndicatorLabel.text = loginVM.preLoginAttemptLabel
        self.scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
    }
    
    
    // login button action called this
    @IBAction func loginButtonAction(_ sender: Any) {
        
        // checking if email field is empty or not
        guard let email = emailField.text , email != "" else {
            self.showAlert(msg: loginVM.emailWarning, action: nil)
            return
        }
        
        // checking if the user put password field empty
        guard let upass = passwordField.text , upass != ""  else{
            self.showAlert(msg: loginVM.passwordWarning, action: nil)
            return
        }
        loginVM.delegate = self
        activityIndicator.startAnimating()
        self.resignTextFields()
        loginInfoIndicatorLabel.text = loginVM.activeLoginAttemptLabel
        loginVM.login(uEmail:email , uPass: upass)
        
    }
    
    
    // resign all textFields
    func resignTextFields(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    // show home
    func showHome(){
        present(WithAnimation: loginVM.homeVC)
    }
    
    // show profile page
    func showProfile(){
        present(WithAnimation: loginVM.profileVC)
    }
    // show profile setup view controller
    func showProfileSetUpPage(){
        let profileSetupViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileSetupPageView")
        self.present(WithAnimation: profileSetupViewController!)
    }
    
    func showAlert(msg:String! , action: String?){
        let alert:UIAlertController!
        if let act = action{
            alert = UIAlertController(msg:msg ,action:act)
        }else{
            alert = UIAlertController(okaction:msg)
        }
        present(WithAnimation: alert)
    }
    
}
