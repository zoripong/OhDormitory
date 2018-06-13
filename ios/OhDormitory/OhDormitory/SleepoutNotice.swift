//
//  SleepoutNotice.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation

class SleepoutNotice : Notice{
    /*
     "application_deadline": "2018-06-30",
     "sleep_w_time": "2018-06-30",
     "sleep_d_time": "2018-06-30",
     "send": "0"
     */
    var application_deadline : String
    var sleep_w_time : String
    var sleep_d_time: String
    var send : Int
    init(notice_id:Int, title:String, type:Int, w_time:String, d_time:String, application_deadline:String, sleep_w_time:String, sleep_d_time:String, send:Int){
        self.application_deadline = application_deadline
        self.sleep_w_time = sleep_w_time
        self.sleep_d_time = sleep_d_time
        self.send = send
        super.init(notice_id: notice_id, title: title, type: type, w_time: w_time, d_time: d_time)
    }
}
