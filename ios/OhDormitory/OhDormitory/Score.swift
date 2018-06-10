//
//  Score.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 10..
//  Copyright © 2018년 doori. All rights reserved.
//

import Foundation

class Score {
    
    
    var score_id:Int
    var detail:String
    var score:Double
    init(score_id:Int, detail:String, score:Double){
        self.score_id = score_id
        self.detail = detail
        self.score = score
    }
}

