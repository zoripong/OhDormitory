//
//  Notice.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation
class Notice {
    /*
     "notice_id": "65",
     "title": "뇽뇽",
     "type": "0",
     "w_time": "2018-06-11",
     "d_time": "2018-06-30"
     */
    var notice_id:Int
    var title:String
    var type:Int
    var w_time:String
    var d_time:String
    
    init(notice_id:Int, title:String, type:Int, w_time:String, d_time:String){
        self.notice_id = notice_id
        self.title = title
        self.type = type
        self.w_time = w_time
        self.d_time = d_time
    }
}
