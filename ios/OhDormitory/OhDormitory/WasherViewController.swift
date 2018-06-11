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

   
    @IBOutlet var washerButtonGroup: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func getData(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Download file or perform expensive task
            
            //요청할 url
            let components = URLComponents(string: "http://54.203.113.95/getWashList.php")
            //요청변수
            
            // get User Data
          
          //  let parent_phone = defaults.string(forKey: "parent_phone") ?? "Unknown user"
            
            // print("이거"+emirim_id)
            // print("이거"+parent_phone)
//
//            components?.queryItems = [
//                URLQueryItem(name: "userID", value: emirim_id)
//            ]
            
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                // print(response!)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    
//                    var washer_nums : [String] = [String()]
//                    var wash_times : [String] = [String()]
//                    var using_rooms : [String] = [String()]

                    
                    DispatchQueue.main.async {
                        
                        
                        
                        if let wash_existing_users =  json["wash_existing_user"] as? [[String: Any]]{
                            print("리턴 데이터 : ",wash_existing_users);
                            for wash_existing_user in wash_existing_users {
                                
                                let washer_num : String = wash_existing_user["washer_num"]! as! String
                                let wash_time : String = wash_existing_user["wash_time"] as! String
                                
                                let using_room : String = wash_existing_user["using_room"] as! String

//                                washer_nums.append(washer_num)
//                                wash_times.append(wash_time)
//                                using_rooms.append(using_room)
                             //   if(return_code == 2){
                                self.setExistingUser(washer_num: washer_num,wash_time: wash_time,using_room: using_room)
                             //   }else{
                            //        self.setSleepoutInfo(message :return_message)
                             //   }
                            }//for
                            
                        }//return_data
                        
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
        
       print("1",washer_num)
        print("2",wash_time)
        print("3",using_room)
        print("표시",display_washer_num + (2 * display_washer_num))
        print("표시",display_washer_time)

        
        
    }
}
