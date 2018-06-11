//
//  WasherViewController.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class WasherViewController: UIViewController {
    
    private var user_room_floor : Int = -1;
    
    private var time_type : Int = -1;
    var washer_using_room = [[String]](repeating: Array(repeating: "0",count: 3 ), count: 3)
    
    
    @IBOutlet weak var timeLabel_1: UILabel!
    @IBOutlet weak var timeLabel_2: UILabel!
    @IBOutlet weak var timeLabel_3: UILabel!
    
    
    //private var alert_message_room : String = "";

   
    @IBOutlet var washerButtonGroup: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTimeType()
        
        let defaults = UserDefaults.standard
        let user_room_num = defaults.integer(forKey: "room_num")
        if(user_room_num<500){
            user_room_floor=4;
        }else{
            user_room_floor=5;

        }
        getData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTimeType(){
        
        let cal = Calendar(identifier: .gregorian)
        let now = Date()
        let today = cal.dateComponents([.weekday,.hour],from:now)
        
       
        //일요일 1 ~ 토요일 7
        print("요일 : ",today.weekday!)
//        var timeList = ["06:00 ~ 07:00", "07:00 ~ 08:00", "08:00 ~ 09:00",
//                        "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "20:00 ~ 21:30",
//                        "21:30 ~ 22:30", "22:30 ~ 23:30"
//        ];
        if today.weekday == 1 || today.weekday == 7{
            print("시간 : ",today.hour!)
            if today.hour! < 9 {
                time_type = 0
            }else if today.hour! < 12 {
                time_type = 3
            }else {
                time_type = 6
            }
        }else{
            time_type = 6
        }
        
    }
    
    func getData(){
        DispatchQueue.global(qos: .userInitiated).async {
            
            //요청할 url
            let components = URLComponents(string: "http://54.203.113.95/getWashList.php")
     
            
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                // print(response!)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    

                    DispatchQueue.main.async {
                        
                        
                        
                        if let wash_existing_users =  json["wash_existing_user"] as? [[String: Any]]{
                            print("리턴 데이터 : ",wash_existing_users);
                            for wash_existing_user in wash_existing_users {
                                
                                let washer_num : String = wash_existing_user["washer_num"]! as! String
                                let wash_time : String = wash_existing_user["wash_time"] as! String
                                
                                var using_room : String = wash_existing_user["using_room"] as! String

                                using_room = using_room + "호"
                                self.setExistingUser(washer_num: washer_num,wash_time: wash_time,using_room: using_room)
                            
                            }//for
                            
                        }//wash_existing_users
                        
                        if let wash_applying_users =  json["wash_applying_user"] as? [[String: Any]]{
                            print("리턴 데이터 : ",wash_applying_users);
                            for wash_applying_user in wash_applying_users {
                                
                                let washer_num : String = wash_applying_user["washer_num"]! as! String
                                let wash_time : String = wash_applying_user["wash_time"] as! String
                                
                                let emirim_id : String = wash_applying_user["emirim_id"] as! String
                                
                                self.setExistingUser(washer_num: washer_num,wash_time: wash_time,using_room: emirim_id)
                                
                            }//for
                            
                        }//wash_existing_users
                        
                    }//ui updating
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
        }
    }
    func setExistingUser(washer_num:String,wash_time:String,using_room:String){
        if user_room_floor == 4 && Int(washer_num)!>=3{
            return
        }
        else if user_room_floor == 5 && Int(washer_num)!<3{
            return
        }
        if Int(wash_time)! < time_type ||  Int(wash_time)! > time_type + 2{
            
            return
            
        }
        var display_washer_num : Int
        
        if Int(washer_num)!>=3{
            display_washer_num = Int(washer_num)! - 3
        }
        else{
            display_washer_num = Int(washer_num)!
        }
        
        var display_washer_time : Int
        display_washer_time = Int(wash_time)! % 3
        
        let buttonIndex : Int = display_washer_num + (2 * display_washer_num) + display_washer_time
        
        washerButtonGroup[buttonIndex].backgroundColor = UIColor.blue

        washer_using_room[display_washer_num][display_washer_time] = using_room
       
        washerButtonGroup[buttonIndex].titleLabel?.text = String(display_washer_num) + "_" + String(display_washer_time);
        washerButtonGroup[buttonIndex].addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        
       

        
        
    }
  
    @objc func buttonPressed(_ sender: UIButton!) {
        let buttonTitle = sender.titleLabel?.text
        let buttonIndex = buttonTitle?.split(separator: "_")
        let washer_num : Int = Int(buttonIndex![0])!
        let washer_time : Int = Int(buttonIndex![1])!
        
        let message = washer_using_room[washer_num][washer_time]
        
        let alert = UIAlertController(title: "이미 예약되어있는 자리입니다.", message: message+"에서 사용중입니다.", preferredStyle: .alert)

       // alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
