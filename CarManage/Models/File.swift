//
//  File.swift
//  CarManage
//
//  Created by GOgi on 4/6/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import Foundation

class User : NSObject {
    var name:String = ""
    var address:String = ""
    
    override init() {
        name = ""
        address = ""
    }
    
    init(name : String, address : String) {
        self.name = name
        self.address = address
    }
}
