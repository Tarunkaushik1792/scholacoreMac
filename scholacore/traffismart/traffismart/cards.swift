//
//  cards.swift
//  traffismart
//
//  Created by Tarun kaushik on 09/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import Foundation

struct Card{
    
    var mainInfoLabel:String!
    var mainLabel:String!
    var extraInfo:String!
    var backGroundColor:UIColor!
    
    init(_ mainInfo:String! , _ mainLab:String! , _ extra:String?) {
        self.mainLabel = mainLab
        self.mainInfoLabel = mainInfo
        self.extraInfo = extra
        self.backGroundColor = UIColor.white
    }
    
}
