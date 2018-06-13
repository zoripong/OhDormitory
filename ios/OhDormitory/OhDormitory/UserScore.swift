//
//  UserScore.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation
class UserScore {
    var id:Int
    var date:String
    var score_id:Int
    init(id:Int, date:String, score_id:Int){
        self.id = id
        self.date = date
        self.score_id = score_id
    }
}
