//
//  Lecture.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation

struct lecture{
    let subject:String!
    //let subjectID:String?
    let hour:Int?
    let minute:Int?
    let Duration:Int?
    let StartTime:Date!
    let finishTime:Date!
    let color:Int!
    
    init(subject:String! ,Hour:Int! , Minute:Int , Duration: Int , color:Int){
        self.subject = subject
        self.hour = Hour
        self.minute = Minute
        self.Duration = Duration
        self.StartTime = Date().dateAt(hours: Hour, minutes: Minute)
        self.color = color
        if (minute! + Duration) < 60{
            self.finishTime = Date().dateAt(hours: Hour, minutes: Minute + Duration)
        }else{
            let extratime = (Minute + Duration) - 60
            self.finishTime = Date().dateAt(hours: Hour + 1, minutes: extratime)
        }
    }
    
}

