//
//  userProfileTableViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class userProfileTableViewController: UITableViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate,userProfileDelegate{
    @IBOutlet var userProfileVM: userProfileModel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var usernNameTF: UITextField!
    @IBOutlet var erpIdTf: UITextField!
    @IBOutlet var courseTf: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var doneBarButton:UIBarButtonItem!
    var cancelBarButton:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "PROFILE"
        //doneBarButton = self.tabBarController?.navigationItem.rightBarButtonItem
       // cancelBarButton = self.tabBarController?.navigationItem.leftBarButtonItem
       // doneBarButton.isEnabled = false
       // cancelBarButton.isEnabled = false
        loadUserProfile()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func loadUserProfile(){
        activityIndicator.startAnimating()
        activityIndicator.show()
        userProfileVM.delegate = self
        userProfileVM.loadUserData()
        userProfileVM.loadUserImage()
    }
    
    func addObservers(){
        // usernNameTF.addTarget(self, action: #selector(self.savedata), for: .editingDidEnd)
    }
    
    func userProfileInfo(userInfo: User) {
        usernNameTF.text = userInfo.username
        erpIdTf.text = userInfo.userRoll
        courseTf.text = userInfo.userCourse
    }
    
    func errorHandler(error: Error?) {
        showAlert(msg: (error?.localizedDescription)!)
    }
    
    func userProfilePicLoaded(userImage: UIImage) {
        profileImageView.image = userImage
        activityIndicator.hide()
        activityIndicator.stopAnimating()
    }
    
    func didFinishedSavingUserData() {
        userProfileVM.loadUserData()
        //doneBarButton.isEnabled = false
        self.tabBarController?.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    func savedata(){
        let uibusy = UIActivityIndicatorView(activityIndicatorStyle: .white)
        uibusy.hidesWhenStopped = true
        uibusy.startAnimating()
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: uibusy)
        resignAllTextFields()
        userProfileVM.saveUserData(userName: usernNameTF.text!, userRoll: erpIdTf.text!, userCourse: courseTf.text!)
    }
    
    func cancelChange(){
        resignAllTextFields()
        userProfileVM.loadUserData()
    }
    
    func resignAllTextFields(){
        usernNameTF.resignFirstResponder()
        erpIdTf.resignFirstResponder()
        courseTf.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        savedata()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       // doneBarButton.isEnabled = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  cancelBarButton.isEnabled = true
       // doneBarButton.isEnabled = true
    }
    
    @IBAction func logOut(_ sender: Any) {
        userProfileVM.logout()
        performSegue(withIdentifier: "unwindToLogin", sender: self)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginPage")
        navigationController?.popToRootViewController(animated: true)
        present(WithAnimation: vc!)
    }
    
    @IBAction func changeImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            present(WithAnimation: picker)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        profileImageView.image = image
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        userProfileVM.saveUserImage(uImage: image)
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(msg:String){
        let alert = UIAlertController(okaction:msg)
        present(WithAnimation: alert)
    }
}
