//
//  NotificationsViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import UIKit

class NotificationsViewController: UITableViewController ,NotificationDelegate{
    
    @IBOutlet var notificationVM: NotificationViewModel!
    @IBOutlet var noticeBoardView:UITableView!
    /* var notifications = ["Welcome to the class of 2017 your session will start at 9:00Am" , "All the students are informed to be present at auditorium for morning session","Classes timing for 27th may 2017 is from 8:50Am " , "Proper Dress Code is adviced to all students during exams session" , "Last Date for filling the examincation form is 29th august 2017", "All CRC members are called up for meeting at 1 O'clock with the director sir"]*/
    var notifications = [FBNotification]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        notificationVM.delegate = self
        notificationVM.downloadNotifications()
       // notificationVM.newDownloadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let barButton = tabBarController?.navigationItem.rightBarButtonItem
        barButton?.target = self
        barButton?.action = #selector(self.addNotification)
        
    }
    
    func didFinishedDownloadingInitialNotifications(notifications: [FBNotification]) {
        self.notifications = notifications
        noticeBoardView.reloadData()
        
    }
    
    func didFinishedDownloadingNewNotification(notification: FBNotification) {
        self.notifications.insert(notification, at: 0)
        noticeBoardView.reloadData()
    }
    
    func didFinishedDownloaingMoreNotifications(notifications: [FBNotification]) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = #imageLiteral(resourceName: "list-simple-7")
        cell.textLabel?.text = notifications[indexPath.row].message
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func addNotification(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationPage")
        navigationController?.pushViewController(vc!, animated: true)
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

