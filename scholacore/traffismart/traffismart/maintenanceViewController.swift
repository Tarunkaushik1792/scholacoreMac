//
//  maintenanceViewController.swift
//  traffismart
//
//  Created by Tarun kaushik on 10/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class maintenanceViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     slideMenu()
        // Do any additional setup after loading the view.
    }

    func slideMenu(){
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    @IBAction func contactAction(_ sender: Any) {
        let menu = UIAlertController(title:"Contatn galaxy service ",message:"call and fix an current apointment ",preferredStyle:.actionSheet)
        let action = UIAlertAction(title:"Call 1800-890802" , style:.default , handler: nil)
        let cancel = UIAlertAction(title:"Cancel" , style: .cancel , handler: nil)
        menu.addAction(cancel)
        menu.addAction(action)
        present(menu , animated: true)
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
