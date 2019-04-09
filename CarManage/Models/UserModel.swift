//
//  UserModel.swift
//  CarManage
//
//  Created by GOgi on 4/8/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import Foundation

class UserModel : NSObject {
    var username = ""
    var user_id = 0
    var email = ""
    var password = ""
    
    override init() {
        
    }
    
    init(dic:[String: Any]) {
        if let val = dic["username"] as? String                 {username = val}
        if let val = dic["user_id"] as? Int                     {user_id = val}
        if let val = dic["email"] as? String                    {email = val}
        if let val = dic["password"] as? String                 {password = val}
    }
}
