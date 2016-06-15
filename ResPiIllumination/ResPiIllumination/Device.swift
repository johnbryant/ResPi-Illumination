//
//  device.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import Foundation

class Device: NSObject {
    
    var id: Int!
    
    var name: String!
    var iconName: String!
    var information: String!
    var on: Bool!
    var workable: Bool!
    
    
    override init() {
        super.init()
        self.id = 100
        self.name = "卧室壁灯"
        self.iconName = "whiteBulb"
        self.information = ""
        self.on = false
        self.workable = true
    }
    
    init(id: Int, name: String, iconName: String, information: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.information = information
        self.on = false
        self.workable = true
    }
}
