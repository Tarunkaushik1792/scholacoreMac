//
//  displaypictureViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import Firebase

class displaypictureViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate,ProfileSetupDelegate{
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var profileSetupVM: ProfileSetupModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func profileImagePickerAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            present(imagePicker,animated: true , completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let parentVC = parent as! ProfileSetupPageViewController
        parentVC.backWard()
    }
    
    
    func errorHandler(error: Error?) {
        
    }
    
    
    
    func didFinishedUploadingUserProfileImage(metadata: FIRStorageMetadata?) {
        self.activityIndicator.stopAnimating()
        let alert = UIAlertController(title:"Your setup is complete" , message: nil , preferredStyle: .alert)
        let alertAction = UIAlertAction(title:"Let Start!" , style: .cancel , handler : {(action) in
            self.showHome()})
        alert.addAction(alertAction)
        self.present(alert , animated: true , completion: nil)
        self.showHome()
    }
    
    
    @IBAction func saveProfileButton(_ sender: Any) {
        activityIndicator.startAnimating()
        profileSetupVM.delegate = self
        let imageData = UIImageJPEGRepresentation(profileImageView.image!, 0.5)
        profileSetupVM.saveProfileImage(imageData: imageData!)
    }
    
    
    func showHome(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Home")
        present(vc! , animated: true , completion: nil )
    }
    
    
    func showAlert(msg: String! , action : String?){
        if let act = action {
            let alert = UIAlertController(msg:msg , action: act)
            present(alert,animated: true , completion: nil)
            return
        }else{
            let alert = UIAlertController(okaction:msg)
            present(alert , animated: true , completion: nil)
        }
        
    }
}
