//
//  BasicNotice.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation

class BasicNotice : Notice{
    var content : String
    init(notice_id:Int, title:String, type:Int, w_time:String, d_time:String, content:String){
        self.content = content
        super.init(notice_id: notice_id, title: title, type: type, w_time: w_time, d_time: d_time)
    }
}

