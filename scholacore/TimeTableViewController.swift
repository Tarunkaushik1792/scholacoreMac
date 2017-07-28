//
//  TimeTableViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

//
//  TimeTableViewController.swift
//  Scholacore
//
//  Created by Tarun kaushik on 16/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import FirebaseMessaging
import Firebase

class TimeTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TimeTableCellDelegate {
    @IBOutlet var weekdaysSegmentController: UISegmentedControl!
    @IBOutlet var subjectsTableView: UITableView!
    var newView:UIView?
    @IBOutlet var weekdayContainerView: UIView!
    var editable = false
    
   /* var subjects = ["Project Management", "SPSS","Break" , "Research Methodology","Financial Accounting","Break","Managerial Economics","Principles of Management","Thoery of Everything" , "Engineering maths"]*/
    var subjects = [lecture(subject:"POM" , Hour:9 , Minute:10,Duration: 55, color: 0x607D8B),lecture(subject:"spss" , Hour:10 , Minute:5,Duration: 55, color: 0xFF9800),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Research Methodology" , Hour:11 , Minute:15, Duration: 55, color: 0xCDDC39),lecture(subject:"Financial Accounting" , Hour:12 , Minute:10, Duration: 55, color: 0x03A9F4),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Managerial economics" , Hour:13, Minute:45, Duration: 55, color: 0x673AB7),lecture(subject:"Principles of Management" , Hour:14 , Minute:40, Duration: 55, color: 0x795548),lecture(subject:"Principles of Management" , Hour:15 , Minute:35, Duration: 55, color: 0x8BC34A),lecture(subject:"Principles of Management" , Hour:16 , Minute:30, Duration: 30, color: 0x2196F3)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //var timetable = timeTableViewModel()
        //timetable.createTimeTable()
        //timetable.createLecture()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //subjectsTableView.frame = CGRect(x:0,y:123,width:view.bounds.size.width,height:view.bounds.size.height-123)
        let switchButton = UISwitch()
        switchButton.isUserInteractionEnabled = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: switchButton)
        NotificationCenter.default.addObserver(self, selector: #selector(self.forgroundAction), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        setUpWeekDay()
        //self.tabBarItem.badgeColor = UIColor.red
        //self.tabBarItem.badgeValue = "1"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let barButton = tabBarController?.navigationItem.rightBarButtonItem
        barButton?.target = self
        barButton?.action = #selector(self.editTimeTable)
        //i m here
        self.forgroundAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func setUpWeekDay(){
        let date = Date()
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let  myComponet = calender?.components(.weekday, from: date)
        let weekDay = myComponet?.weekday
        if weekDay != 1{
            weekdaysSegmentController.selectedSegmentIndex = weekDay! - 2
            weekdaysSegmentController.sendActions(for: UIControlEvents.valueChanged)
        }else{
            newView = UIView(frame:CGRect(x:subjectsTableView.frame.minX,y:subjectsTableView.frame.minY,width: self.view.bounds.width , height: subjectsTableView.frame.height))
            if let newV = newView{
            let label = UILabel(frame:CGRect(x:newV.bounds.width/2 - 100 ,y:newV.bounds.height/2 - 25 , width:200, height: 50))
            print("lable frame \(label.frame) and label bounds \(label.bounds)")
            print("new view frame \(newV.frame) and subjectViewFrame \(subjectsTableView.frame)")
            label.backgroundColor = UIColor.white
            newV.backgroundColor = UIColor.blue
            label.text = "HOLIDAY"
            label.textAlignment = .center
            label.textColor = UIColor.red
            label.font = UIFont(name: "HelveticaNeue" , size: 36)
            newV.addSubview(label)
            //subjectsTableView.removeFromSuperview()
            weekdaysSegmentController.selectedSegmentIndex = UISegmentedControlNoSegment
            self.view.addSubview(newV)
            }}
    }
    
    func editTimeTable(){
        
      //  subjectsTableView.setEditing(true, animated: true)
        editable = true
        subjectsTableView.reloadData()
        tabBarController?.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done ,target:self , action: #selector(self.doneEditing) ), animated: true)
    }
    
    func doneEditing(){
        //subjectsTableView.setEditing(false, animated: true)
        editable = false
        subjectsTableView.reloadData()
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit , target: self , action: #selector(self.editTimeTable))
    }
    
    @IBAction func segmentController(_ sender: Any) {
        
        switch weekdaysSegmentController.selectedSegmentIndex{
        case 0 :
            subjects = [lecture(subject:"Service Marketing" , Hour:21 , Minute:10,Duration: 55, color: 0xFFB74D),lecture(subject:"Service Marketing" , Hour:10 , Minute:5,Duration: 55, color: 0xFFB74D),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Entrepreneurship Development" , Hour:11 , Minute:15, Duration: 55, color: 0x26A69A),lecture(subject:"Operation Research" , Hour:12 , Minute:10, Duration: 55, color: 0x9FA8DA),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Strategic Management" , Hour:13, Minute:45, Duration: 55, color: 0x78909C),lecture(subject:"CRC" , Hour:14 , Minute:40, Duration: 55, color: 0xBA68C8),lecture(subject:"Consumer Behaviour" , Hour:15 , Minute:35, Duration: 55, color: 0xBDBDBD),lecture(subject:"Mentoring" , Hour:17 , Minute:30, Duration: 30, color: 0xFF8A65)]
            subjectsTableView.reloadData()
            subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        case 1 :
              subjects = [lecture(subject:"Investment Analysis And Portfolio Mangement" , Hour:9 , Minute:10,Duration: 55, color: 0x0097A7),lecture(subject:"Investment Analysis And Portfolio Mangement" , Hour:10 , Minute:5,Duration: 55, color: 0x0097A7),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Digital Marketing" , Hour:11 , Minute:15, Duration: 55, color: 0xF48FB1),lecture(subject:"Digital Marketing" , Hour:12 , Minute:10, Duration: 55, color: 0xF48FB1),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Operation Research" , Hour:13, Minute:45, Duration: 55, color: 0x9FA8DA),lecture(subject:"Consumer Behaviour" , Hour:14 , Minute:40, Duration: 55, color: 0xBDBDBD),lecture(subject:"Management Of Financial Services" , Hour:15 , Minute:35, Duration: 55, color: 0xA18875),lecture(subject:"Mentoring" , Hour:16 , Minute:30, Duration: 30, color: 0xFF8A65)]
            
            subjectsTableView.reloadData()
            subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        case 2 :
              subjects = [lecture(subject:"Corporate Taxation" , Hour:9 , Minute:10,Duration: 55, color: 0xE57373),lecture(subject:"Corporate Taxation" , Hour:10 , Minute:5,Duration: 55, color: 0xE57373),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Customer Relationship Management" , Hour:11 , Minute:15, Duration: 55, color: 0x7CB342),lecture(subject:"Customer Relationship Management" , Hour:12 , Minute:10, Duration: 55, color: 0x7CB342),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Strategic Management" , Hour:13, Minute:45, Duration: 55, color: 0x78909C),lecture(subject:"Innovation Tech. & Change Management" , Hour:14 , Minute:40, Duration: 55, color: 0x00B8D4),lecture(subject:"Entrepreneurship Development" , Hour:15 , Minute:35, Duration: 55, color: 0x26A69A),lecture(subject:"OFF" , Hour:16 , Minute:30, Duration: 30, color: 0x000000)]
            subjectsTableView.reloadData()
            subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        case 3 :
              subjects = [lecture(subject:"Innovation Tech. & Change Management" , Hour:9 , Minute:10,Duration: 55, color: 0x00B8D4),lecture(subject:"Innovation Tech. & Change Management" , Hour:10 , Minute:5,Duration: 55, color: 0x00B8D4),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Entrepreneurship Development" , Hour:11 , Minute:15, Duration: 55, color: 0x26A69A),lecture(subject:"Strategic Management" , Hour:12 , Minute:10, Duration: 55, color: 0x78909C),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Operations Research" , Hour:13, Minute:45, Duration: 55, color:0x9FA8DA),lecture(subject:"Financial Risk Management" , Hour:14 , Minute:40, Duration: 55, color:  0xE1BEE7),lecture(subject:"Aptitude Training" , Hour:15 , Minute:35, Duration: 55, color: 0xFFAB00),lecture(subject:"Aptitude Training", Hour:16 , Minute:30, Duration: 30, color: 0xFFAB00)]
            subjectsTableView.reloadData()
            subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        case 4 :
              subjects = [lecture(subject:"CRC" , Hour:9 , Minute:10,Duration: 55, color: 0xBA68C8),lecture(subject:"Corporate Taxation" , Hour:10 , Minute:5,Duration: 55, color: 0xE57373),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Strategic Management" , Hour:11 , Minute:15, Duration: 55, color: 0x78909C),lecture(subject:"Entrepreneurship Development" , Hour:12 , Minute:10, Duration: 55, color: 0x26A69A),lecture(subject:"Break" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"Operation Research" , Hour:13, Minute:45, Duration: 55, color: 0x9FA8DA),lecture(subject:"Consumer Behaviour" , Hour:14 , Minute:40, Duration: 55, color: 0xBDBDBD),lecture(subject:"Financial Risk Management" , Hour:15 , Minute:35, Duration: 55, color: 0xE1BEE7),lecture(subject:"OFF" , Hour:16 , Minute:30, Duration: 30, color: 0x000000)]
            subjectsTableView.reloadData()
            subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        case 5 :
              subjects = [lecture(subject:"Management Of Financial Services" , Hour:9 , Minute:10,Duration: 55, color: 0xA18875),lecture(subject:"Management Of Financial Services" , Hour:10 , Minute:5,Duration: 55, color: 0xA18875),lecture(subject:"Break" , Hour:9 , Minute:5,Duration: 10, color: 0x8BC34A),lecture(subject:"Strategic Management" , Hour:11 , Minute:15, Duration: 55, color: 0x78909C),lecture(subject:"Innovation Tech. & Change Management" , Hour:12 , Minute:10, Duration: 55, color: 0x00B8D4),lecture(subject:"OFF" , Hour:9 , Minute:5, Duration: 30, color: 0x3F51B5),lecture(subject:"OFF" , Hour:13, Minute:45, Duration: 55, color: 0x03A9F4),lecture(subject:"OFF" , Hour:14 , Minute:40, Duration: 55, color: 0x8BC34A),lecture(subject:"OFF" , Hour:15 , Minute:35, Duration: 55, color: 0xCDDC39),lecture(subject:"OFF" , Hour:16 , Minute:30, Duration: 30, color: 0xffffff)]
            subjectsTableView.reloadData()
          subjectsTableView.scrollToRow(at: IndexPath(row:0,section:0), at: .top, animated: true)
            if let newV = newView{
                newV.removeFromSuperview()
            }
            
        default: break
        }
        
    }
    
    // MARK: - Table view data source
    
    func forgroundAction(){
        subjectsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if subjects[indexPath.row].subject == "Break"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "breaKcell", for: indexPath)
            return cell
        }else if subjects[indexPath.row].subject == "OFF"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "off", for: indexPath)
            return cell
        }else if editable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath) as! editTableViewCell
            cell.subjectNameLabel.text = subjects[indexPath.row].subject
            cell.backgroundColor = UIColor(hex:subjects[indexPath.row].color)
            cell.lectureINfo = subjects[indexPath.row]
            cell.setup()
        return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimeTableViewCell
            cell.selectedSegment = weekdaysSegmentController.selectedSegmentIndex
            cell.subjectLabelView.text = subjects[indexPath.row].subject
            cell.lectureINfo = subjects[indexPath.row]
            cell.delegate = self
            cell.setupCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if subjects[indexPath.row].subject == "Break"{
            return 20.0
        }else{
            return 60.0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !editable && subjects[indexPath.row].subject != "OFF"{
        let vc = storyboard?.instantiateViewController(withIdentifier: "subjectDetail") as! subjectDetailsTableView
        vc.subjectTitle = subjects[indexPath.row].subject
            navigationController?.pushViewController(vc, animated: true)
        }else{
        let vc = storyboard?.instantiateViewController(withIdentifier: "lectureEdit") as! lectureEditTableViewController
            vc.lectureTitle = "lecture \(indexPath.row + 1)"
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func timerDidFinished() {
        subjectsTableView.reloadData()
    }
    
}

