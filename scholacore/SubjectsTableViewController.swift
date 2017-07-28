//
//  SubjectsTableViewController.swift
//  scholacore
//
//  Created by Himanshu Kaushik on 23/07/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

protocol SubjectPickerDelegate:class{
    func didFinishSelectingSubject(subject:String ,color:Int)
}

class SubjectsTableViewController: UITableViewController,subjectDelegate,FIRSubjectDelegate {
    func didFinishUpdateingSubject(Subject: Subject) {
        
    }
    
    
    func didFinishedAddingSubjectToDataBase(subject: Subject) {
        print(subjectsList)
        subjectsList.append(subject)
        tableView.insertRows(at: [IndexPath(row:subjectsList.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    
    func didFinishedRemovingSubject(atIndexPath indexPath: IndexPath) {
        colors.append(subjectsList[indexPath.row].colorCode!)
       subjectsList.remove(at: indexPath.row)
       tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    var subjectsList:[Subject] = []
    var lectureEntry = false
    
    func didFinishedDownloadingSubjectList(Subjects: [Subject]) {
        self.subjectsList = Subjects
        tableView.reloadData()
    }
    
    func errorEncountered(error: String) {
        let alert = UIAlertController(okaction: error)
        present(WithAnimation: alert)
    }
    

    func didFinishedUpdatingSubject() {
        
    }
    
    

    
    func didFinishAddingSubject(Subject: Subject) {
        var subject = Subject
        //subjects.append(Subject)
        guard subjectsList.count + 1  <= colors.count else{
            let alert = UIAlertController(okaction:"Sorry its the limit of subject")
            present(WithAnimation: alert)
            return
        }
        subject.colorCode = colors[0]
        colors = colors.filter{$0 != subject.colorCode}
        addToDB(subject:subject)
        
    }
    
    func addToDB(subject:Subject){
        let subjectVm = SubjectViewModel()
        subjectVm.delegate = self
       subjectVm.addSubject(subject: subject)
    }

    weak var delegate:SubjectPickerDelegate?
    var colors = [0x607D8B,0xFF9800,0x8BC34A,0xCDDC39,0x03A9F4,0x3F51B5,0x673AB7,0x795548,0x8BC34A,0x2196F3,0x78909C,0x9FA8DA,0x26A69A,0x00B8D4,0xBA68C8,0x0097A7,0xA18875,0xBDBDBD,0xFFB74D, 0xE57373,0xE1BEE7,0xF48FB1,0x7CB342,0xFFAB00 ,0xFF8A65]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let subjectVm = SubjectViewModel()
        subjectVm.delegate = self
        subjectVm.loadSubjectList()
        if lectureEntry{
            
        }else{
            let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add , target: self , action : #selector(self.addSubject))
            navigationItem.title = "SUBJECTS"
            navigationItem.setRightBarButton(addButton, animated: true)
        }
       
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSubject(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddSubject") as! ADDSUBJECTController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjectsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let colorCode = subjectsList[indexPath.row].colorCode{
        cell.backgroundColor = UIColor(hex: colorCode)
            colors = colors.filter{$0 != colorCode}
        }else{
            cell.backgroundColor = UIColor(hex: colors[0])
        }
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "\((subjectsList[indexPath.row].name)!)"
        if !lectureEntry{
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lectureEntry{
        delegate?.didFinishSelectingSubject(subject: subjectsList[indexPath.row].name,color:subjectsList[indexPath.row].colorCode!)
            navigationController?.popViewController(animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddSubject") as! ADDSUBJECTController
            vc.existingsubject = subjectsList[indexPath.row]
            vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
                
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let subjectVm = SubjectViewModel()
            subjectVm.delegate = self
            subjectVm.deleteSubject(key: subjectsList[indexPath.row].subjectID, indexPath: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }
    

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
