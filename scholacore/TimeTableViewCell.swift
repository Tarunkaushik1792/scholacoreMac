//
//  TimeTableViewCell.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import UIKit

protocol TimeTableCellDelegate:class{
    func timerDidFinished()
    
}

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet var teacherImageView: UIView!
    @IBOutlet var subjectLabelView: UILabel!
    @IBOutlet var timingLabelView: UILabel!
    @IBOutlet var dotVIew: UIView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var timmerLabel: UILabel!
    var selectedSegment:Int!
    var progressiveSec = 0.0
    var timer:Timer!
    var lectureINfo:lecture?
    let calender = Calendar.current
    
    weak var delegate:TimeTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dotVIew.layer.cornerRadius = 7.5
        dotVIew.clipsToBounds = true
        dotVIew.alpha = 0.0
        teacherImageView.layer.cornerRadius = 25
        teacherImageView.clipsToBounds = true
        //subjectLabelView.text = lectureINfo.subject
        progressBar.isHidden = true
        timmerLabel.isHidden = true
        
        
    }
    
    func setupCell(){
       self.backgroundColor = UIColor(hex:(lectureINfo?.color)!)
        let now = Date()
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let dayOfWeek = calender?.component(.weekday, from: now)
        if timer != nil {
            timer.invalidate()
            print("starting new timer and info is \(String(describing: lectureINfo?.subject))")
        }
        if now > (lectureINfo?.StartTime)! && now < (lectureINfo?.finishTime)! && dayOfWeek == (selectedSegment + 2){
            dotVIew.isHidden = false
            progressBar.isHidden = false
            timmerLabel.isHidden = false
            dotVIew.alpha = 0.0
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat,.autoreverse], animations: {
                self.dotVIew.alpha = 1.0
                self.dotVIew.backgroundColor = UIColor.red
            }, completion: { (completed) in
                
            })
            
            UIView.animate(withDuration: 1, animations: {
               // self.backgroundColor = UIColor(red:95/255,green:145/255,blue:21/255,alpha:1.0)
                self.subjectLabelView.textColor = UIColor.white
                self.timmerLabel.textColor = UIColor.white
                self.timingLabelView.textColor = UIColor.blue
                //self.teacherImageView.backgroundColor = UIColor.white
            })
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
            timer.fire()
            
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let startTime = dateFormatter.string(from: (lectureINfo?.StartTime)!)
        let endTime = dateFormatter.string(from: (lectureINfo?.finishTime)!)
        timingLabelView.text = " \(startTime) \n TO \n \(endTime)"
       
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        timmerLabel.isHidden = true
        dotVIew.isHidden = true
        self.backgroundColor = UIColor.white
        self.subjectLabelView.textColor = UIColor.white
        self.timmerLabel.textColor = UIColor.white
        self.timingLabelView.textColor = UIColor.blue
        //self.lectureINfo = nil
        if timer != nil {
            print("starting new timer and info is \(String(describing: lectureINfo?.subject))")
            timer.invalidate()
            timer = nil
        }
        
    }
    
    
    func updateTimerLabel(){
        let comp = calender.dateComponents([.hour,.minute,.second], from: Date())
        let hour = comp.hour
        let mins = comp.minute
        let secs = comp.second
        progressiveSec += 5
        guard let lectInfo = lectureINfo else{
            return
        }
        guard let lecthour = lectInfo.hour else{
            return
        }
        guard let lectmin = lectInfo.minute else{
            return
        }
        guard let lectDuration = lectInfo.Duration else {
            return
        }
        let duration = lectDuration - 1
        if secs! > 49{
            if hour! - lecthour >= 1{
                let remaMintTOHour = 60 - lectmin
                timmerLabel.text = "\(duration - remaMintTOHour - mins! ):0\(59 - secs!)"
                
            }else{
                let reminmint = duration + lectmin
                timmerLabel.text = "\(reminmint - mins!):0\(59 - secs!)"
                
            }
            
        }else{
            if hour! - lecthour >= 1{
                let remaMintTOHour = 60 - lectmin
                timmerLabel.text = "\(duration - remaMintTOHour - mins! ):\(59 - secs!)"
                
            }else{
                let reminMint = duration + lectmin
                timmerLabel.text = "\(reminMint - mins!):\(59 - secs!)"
                
            }
        }
        
        print(lectureINfo?.subject!)
        //let fractionalProgress = Float(progressiveSec/3000.0)
        //progressBar.setProgress(fractionalProgress, animated: true)
        let now = Date()
        if now > (lectureINfo?.finishTime)!{
            timer.invalidate()
            delegate?.timerDidFinished()
        }
        
    }
    
}
