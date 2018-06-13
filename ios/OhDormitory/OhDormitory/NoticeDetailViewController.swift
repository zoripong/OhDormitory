//
//  NoticeDetailViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 12..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class NoticeDetailViewController: UIViewController {
    
    var noticeTitle: String = "aaa"
    var noticeType: Int = -1
    var d_time: String = ""
    var w_time: String = ""
    var content: String = ""
    var cleanAreas: [String] = ["세면실", "세탁실/탈의실", "샤워실", "복도", "휴게실", "계단", "화장실"]
    var cleanDetails: [String] = [""]
    
    var myString: String = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    convenience init( myString: String ) {
        self.init()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = noticeTitle
        contentLabel?.text = content
        dateLabel?.text = "게시날짜 : \(d_time) ~ \(w_time)"
        print(myString)
        
        self.view.backgroundColor = UIColor.white
        
        let tmpL1 = UILabel.init(frame: CGRect.init(x: 100.0, y: 100.0, width: 100.0, height: self.view.bounds.size.width ) )
        tmpL1.text = noticeTitle
        tmpL1.sizeToFit()
        self.view.addSubview( tmpL1 )
        
        let tmpL2 = UILabel.init(frame: CGRect.init(x: 100.0, y: 200.0, width: 100.0, height: self.view.bounds.size.width ) )
        tmpL2.text = "게시날짜 : \(d_time) ~ \(w_time)"
        tmpL2.sizeToFit()
        self.view.addSubview( tmpL2 )
        if noticeType == 0 {
            let tmpL3 = UILabel.init(frame: CGRect.init(x: 100.0, y: 300.0, width: 100.0, height: self.view.bounds.size.width ) )
            tmpL3.text = content
            tmpL3.sizeToFit()
            self.view.addSubview( tmpL3 )
        }else if noticeType == 1{
            print(cleanDetails)
            var x : Double = 50.0
            var y : Double = 300.0
            for area in cleanAreas{
                let tmpLabel = UILabel.init(frame: CGRect.init(x: x, y: y, width: 100.0, height: Double(self.view.bounds.size.width) ) )
                tmpLabel.text = area
                tmpLabel.sizeToFit()
                self.view.addSubview( tmpLabel )
                y += 50
            }
            
            x += 100
            y = 300.0
            var index:Int = 0
            for room in cleanDetails{
                let tmpLabel = UILabel.init(frame: CGRect.init(x: x, y: y, width: 100.0, height: Double(self.view.bounds.size.width) ) )
                tmpLabel.text = room
                tmpLabel.sizeToFit()
                self.view.addSubview( tmpLabel )
                y += 50
                index += 1
                if index == cleanAreas.count{
                    x += 100
                    y = 300.0
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
