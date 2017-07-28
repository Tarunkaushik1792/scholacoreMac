//
//  ADDSUBJECTController.swift
//  scholacore
//
//  Created by Himanshu Kaushik on 25/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

protocol subjectDelegate:class{
    func didFinishAddingSubject(Subject:Subject)
    func didFinishUpdateingSubject(Subject:Subject)
}

class ADDSUBJECTController: UITableViewController {
    
    @IBOutlet var subjectNameTextField: UITextField!
    @IBOutlet var refrenceBookTextField: UITextField!
    var existingsubject:Subject!
    weak var delegate:subjectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done , target: self , action: #selector(self.doneAction))
        navigationItem.setRightBarButton(doneButton, animated: true)
        if existingsubject != nil {
            subjectNameTextField.text = existingsubject.name
            refrenceBookTextField.text = existingsubject.refrence
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func doneAction(){
        var subject = Subject()
        guard subjectNameTextField.text != "" , refrenceBookTextField.text != "" else {
            let alert = UIAlertController(okaction : "Please enter the subject name and refrence")
            present(WithAnimation: alert)
            return
        }
        subject.name = subjectNameTextField.text
        subject.refrence = refrenceBookTextField.text
       
        delegate?.didFinishAddingSubject(Subject: subject)
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
