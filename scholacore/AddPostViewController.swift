//
//  AddPostViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 30/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate,FbPostModelDelegate,UITextViewDelegate{

    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postTextView: UITextView!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var progresViewIndicator: UIProgressView!
    @IBOutlet var postVM: FBPostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "add new post"
        postTextView.layer.borderWidth = 1.0
        postTextView.layer.cornerRadius = 5.0
        postTextView.layer.borderColor = UIColor.gray.cgColor
        postImage.layer.borderWidth = 1.0
        postImage.layer.cornerRadius = 5.0
        postTextView.clipsToBounds = true
        postImage.clipsToBounds = true
        postImage.isUserInteractionEnabled = true
        let tapgasture = UITapGestureRecognizer()
        tapgasture.addTarget(self, action: #selector(self.selectImage))
        postImage.addGestureRecognizer(tapgasture)
        progresViewIndicator.isHidden = true
        let viewTapGasture = UITapGestureRecognizer()
        viewTapGasture.addTarget(self, action: #selector(self.resignKeyboard))
        self.view.addGestureRecognizer(viewTapGasture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectImage(){
        let optionMenu = UIAlertController(title:"select Image From" , message: nil , preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title:"CameraRoll" , style:.default,handler:{(action:UIAlertAction) in self.cameraRoll()})
        let photolibAction = UIAlertAction(title:"Photo Library" , style:.default , handler: {(action:UIAlertAction) in
        self.photoGalary()})
        let cancel = UIAlertAction(cancel:"cancel")
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(photolibAction)
        optionMenu.addAction(cancel)
        present(WithAnimation: optionMenu)
    }
    
    func cameraRoll(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(WithAnimation: imagePicker)
        }
    }
    func photoGalary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(WithAnimation: imagePicker)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        postImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addPostAction(_ sender: Any) {
        postVM.Content = postTextView.text
        postVM.imageAspectRatio = (postImage.image?.size.width)! / (postImage.image?.size.height)!
        postVM.delegate = self
        let data = UIImageJPEGRepresentation(postImage.image!, 0.9)
        postVM.uploadPostImage(imageData: data!)
        progresViewIndicator.isHidden = false
    }
    
    func didFinishedAddingPost() {
        let alert = UIAlertController(withAlertTitle: "Posting complete", msg: "Thankyou for posting", ActionTitle: "OK") { (action) in
             self.performSegue(withIdentifier: "unwindToMainTab", sender: self)
        }
    present(WithAnimation: alert)
       
    }
    
    func uploadProgress(progressFraction: CGFloat) {
        progresViewIndicator.progress = Float(progressFraction)
    }
    
    func errorEncountered(error: String) {
        showAlert(msg: error)
    }
    
    func showAlert(msg:String?){
        let alert = UIAlertController(okaction:msg)
        present(WithAnimation: alert)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postTextView.text == "ENTER THE CONTENT HERE"{
        postTextView.text = ""
        postTextView.textColor = UIColor.black
        }
    }
    
    func resignKeyboard(){
    postTextView.resignFirstResponder()
        if postTextView.text == ""{
        postTextView.text = "ENTER THE CONTENT HERE"
        postTextView.textColor = UIColor.gray
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
