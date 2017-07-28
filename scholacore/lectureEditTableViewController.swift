//
//  lectureEditTableViewController.swift
//  scholacore
//
//  Created by Himanshu Kaushik on 23/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class lectureEditTableViewController: UITableViewController ,SubjectPickerDelegate{

    @IBOutlet var subjectInfoCell: UITableViewCell!
    @IBOutlet var datePickerTextView: UITextField!
    @IBOutlet var duration: UITextField!
    @IBOutlet var subjectNameLabel: UILabel!
    
    let datePicker = UIDatePicker()
    let durationPicker = UIDatePicker()
    var lectureTitle: String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        navigationItem.title = lectureTitle
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func didFinishSelectingSubject(subject: String,color:Int) {
        subjectInfoCell.backgroundColor = UIColor(hex:color)
        subjectNameLabel.textColor = UIColor.white
        subjectNameLabel.text = "\(subject)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createDatePicker(){
        datePicker.datePickerMode = .time
        durationPicker.datePickerMode = .countDownTimer
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done , target : nil , action: #selector(self.doneAction))
        toolbar.setItems([done], animated: true)
        
        datePickerTextView.inputAccessoryView = toolbar
        datePickerTextView.inputView = datePicker
        duration.inputAccessoryView = toolbar
        duration.inputView = durationPicker
    }
    
    func doneAction(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        datePickerTextView.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        duration.text = formatter.string(from: durationPicker.date)
        self.view.endEditing(true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SubjectsTable") as! SubjectsTableViewController
            vc.delegate = self
            vc.lectureEntry = true
            navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.section == 1{
        if indexPath.row == 0 {
            datePickerTextView.becomeFirstResponder()
        }else { duration.becomeFirstResponder()}}
    }
   // override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
   //     return 0
   // }

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
