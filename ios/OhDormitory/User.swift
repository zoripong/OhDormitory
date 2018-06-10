//
//  User.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 9..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation

class User {

    
    var emirim_id:String
    var password:String
    var name:String
    var room_num:Int
    var student_phone:String
    var parent_phone:String

    init(emirim_id:String, password:String, name:String, room_num:Int, student_phone:String, parent_phone:String){
        self.emirim_id = emirim_id;
        self.password = password;
        self.name = name;
        self.room_num = room_num;
        self.student_phone = student_phone;
        self.parent_phone = parent_phone;
    }
    
}


