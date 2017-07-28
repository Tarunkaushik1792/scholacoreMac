//
//  Notification.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation
import UIKit

class FBNotification{
    
    var message:String!
    var TimeStamp:Int!
    var userName:String!
    var key:String!
}

extension FBNotification:Equatable{
    static public func == (rhs:FBNotification , lhs:FBNotification) -> Bool{
        return rhs.key == lhs.key && lhs.key == rhs.key
    }
    
}
