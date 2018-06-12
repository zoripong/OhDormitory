//
//  WasherViewController.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit
import UserNotifications


class WasherViewController: UIViewController {
    
    private var user_room_floor : Int = -1;
    private var emirim_id : String = "";
    private var already_apply_washer_num : Int = -1;
    private var already_apply_washer_time : Int = -1;
    
    private var room_number : Int = -1;
    
    
    private var time_type : Int = -1;
    var washer_using_room = [[String]](repeating: Array(repeating: "0",count: 3 ), count: 3)
    
    private var isApplyingAvailable : Bool = true ;
    
    private let timeList : [String] = ["06:00 ~ 07:00", "07:00 ~ 08:00", "08:00 ~ 09:00",
                            "09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "20:00 ~ 21:30",
                            "21:30 ~ 22:30", "22:30 ~ 23:30"];
    
    @IBOutlet weak var timeLabel_1: UILabel!
    @IBOutlet weak var timeLabel_2: UILabel!
    @IBOutlet weak var timeLabel_3: UILabel!
    
    @IBOutlet weak var applyStatusLabel: UILabel!
    
    @IBAction func pressedApplyButton(_ sender: UIButton) {
        
        if self.applyStatusLabel.text == "취 소"{
            var display_num : Int = already_apply_washer_num
            if display_num>=3{
                display_num -= 3
            }
         
            
             let message = String(display_num+1) + "번 세탁기 " + timeList[already_apply_washer_time] + " 사용을 취소합니다."
            showConfirm(title:"세탁기 사용을 취소하시겠습니까?",message:message,washer_num: already_apply_washer_num,washer_time:already_apply_washer_time,isInsert:false)
        }else{
            
        var possibleWasher = searchPossibleWasher()
        let washer_num : Int = possibleWasher["washer_num"]!
        let washer_time : Int = possibleWasher["washer_time"]!
            
//            print("거",washer_num)
//            print("이가",washer_time)
            
        if washer_time != -1{
            let message = String(washer_num+1) + "번 세탁기를 " + timeList[time_type+washer_time] + "에 사용합니다."
            showConfirm(title:"세탁기 사용을 신청하시겠습니까?",message:message,washer_num: washer_num,washer_time:washer_time,isInsert:true)
        }else{
            showAlert(title:"세탁기 사용을 신청할 수 없습니다.",message:"현재 신청할 수 있는 세탁기가 없습니다.")


        }
//            //todo : 업데이트 성공 시점으로 이동시키기
//            //todo : 포그라운드에서도 되게 하기
//            //todo : network try catch
//            let content = UNMutableNotificationContent()
//            content.title = "세탁 알림 제목"
//
//            content.subtitle = "부제목"
//
//            content.body = "몸뚱아리"
//
//            content.badge = 1
//
//            let calendar = Calendar.current
//            var dateComponents = DateComponents()
//            dateComponents.hour = 2
//            dateComponents.minute = 42
//
//            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
//
//
//            let request = UNNotificationRequest(identifier: "washerpush", content: content, trigger: trigger)
//
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//

            
        }
    }
    
    @IBOutlet weak var applyButton: UIButton!
    //private var alert_message_room : String = "";

   
    @IBOutlet var washerButtonGroup: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            print(didAllow)
        })
        
      
        
        initTimeTable()
        
    }

    func initTimeTable(){
        
        let defaults = UserDefaults.standard
        let user_room_num = defaults.integer(forKey: "room_num")
        emirim_id = defaults.string(forKey: "emirim_id")!
        room_number = user_room_num
        if(user_room_num<500){
            user_room_floor=4;
        }else{
            user_room_floor=5;
            
        }
        
        for i in 0..<3{
            for j in 0..<3{
                washer_using_room[i][j] = "0"
                washerButtonGroup[i+i*2+j].backgroundColor = UIColor.gray

            }
            
        }
        
        getTimeType()
        setTimeInfo()
        getData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTimeType(){
        
        isApplyingAvailable = true

        let cal = Calendar(identifier: .gregorian)
        let now = Date()
        let today = cal.dateComponents([.weekday,.hour,.minute],from:now)
        
       
        //일요일 1 ~ 토요일 7
      //  print("요일 : ",today.weekday!)

        if today.weekday == 1 || today.weekday == 7{
        //    print("시간 : ",today.hour!)
            if today.hour! >= 6 && today.hour! < 9 {
                time_type = 0
            }else if today.hour! >= 9 && today.hour! < 12 {
                time_type = 3
            }else if today.hour! >= 20 && (today.hour! < 23 && today.minute! < 30){
                time_type = 6
            }else{
                isApplyingAvailable = false
                if(today.hour! < 6){
                    time_type = 0
                }else if(today.hour! < 20){
                    time_type = 3
                }else {
                    time_type = 6
                }
            }
        }else{
            time_type = 6
            if today.hour! < 20 || (today.hour! >= 23 && today.minute! >= 30){
                isApplyingAvailable = false
            }
        }
        
    }
    
    func setTimeInfo(){
        if(isApplyingAvailable){
            self.applyButton?.isHidden = false

        }else{
            self.applyButton?.isHidden = true

        }
        self.timeLabel_1.text=timeList[time_type]
        self.timeLabel_2.text=timeList[time_type+1]
        self.timeLabel_3.text=timeList[time_type+2]

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
                           // print("리턴 데이터 : ",wash_existing_users);
                            for wash_existing_user in wash_existing_users {
                                
                                let washer_num : String = wash_existing_user["washer_num"]! as! String
                                let wash_time : String = wash_existing_user["wash_time"] as! String
                                
                                var using_room : String = wash_existing_user["using_room"] as! String

                                using_room = using_room + "호"
                                self.setExistingUser(washer_num: washer_num,wash_time: wash_time,using_room: using_room)
                            
                            }//for
                            
                        }//wash_existing_users
                        
                        if let wash_applying_users =  json["wash_applying_user"] as? [[String: Any]]{
                            self.applyStatusLabel.text = "신 청"

                           // print("리턴 데이터 : ",wash_applying_users);
                            for wash_applying_user in wash_applying_users {
                                
                                let washer_num : String = wash_applying_user["washer_num"]! as! String
                                let wash_time : String = wash_applying_user["wash_time"] as! String
                                
                                let apply_emirim_id : String = wash_applying_user["emirim_id"] as! String
                                

                                if String(String(self.room_number) + "호 "+self.emirim_id) == apply_emirim_id{
                                    self.applyStatusLabel.text = "취 소"
                                    print("내가 신청한 게 있다")
                                    self.already_apply_washer_num = Int(washer_num)!
                                    self.already_apply_washer_time = Int(wash_time)!

                                }
                                
                                self.setExistingUser(washer_num: washer_num,wash_time: wash_time,using_room: apply_emirim_id)
                                
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
        washerButtonGroup[buttonIndex].addTarget(self, action: #selector(washerButtonPressed), for: .touchUpInside)

        
       

        
        
    }
  
    @objc func washerButtonPressed(_ sender: UIButton!) {
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
    
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
        
    }
    func showConfirm(title:String,message:String,washer_num:Int,washer_time:Int,isInsert:Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            
            var real_washer_num : Int = washer_num
            var real_washer_time : Int

            //todo : 신청하기
            if self.user_room_floor == 5 {
                real_washer_num = washer_num + 3
            }
//            print("self.time_type",self.time_type)
//            print("washer_time",washer_time)
            
            real_washer_time = self.time_type + washer_time
            self.applyWasher(washer_num:real_washer_num,washer_time:real_washer_time,isInsert: String(isInsert))
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        
    }
    
    func searchPossibleWasher() -> Dictionary<String, Int>{
        let cal = Calendar(identifier: .gregorian)
        let now = Date()
        let today = cal.dateComponents([.hour,.minute],from:now)
        let time = today.hour!
        
        var possibleWasher : [String:Int] = ["washer_num" : -1 , "washer_time" : -1]
        //일요일 1 ~ 토요일 7
       // print("시간 : ",today.hour!)
        var startIndex : Int = 0
        
        if time == 6 || time == 9 || time == 20{
            startIndex = 0;
        }
        else if time == 7 || time == 10 || time == 21{
            startIndex = 1;
        }
        else if time == 8 || time == 11 || time == 22{
            startIndex = 2;
        }
      //  print("startIndex",String(startIndex))
        
        for i in startIndex..<3{
            for j in 0..<3{
                if washer_using_room[j][i] == "0"{
                    possibleWasher["washer_num"]! =  j
                    possibleWasher["washer_time"]! =  i
                    return possibleWasher
                }
            }
         
            
        }
        possibleWasher["washer_num"]! =  -1
        possibleWasher["washer_time"]! =  -1
        return possibleWasher
    }
    
    func applyWasher(washer_num:Int,washer_time:Int,isInsert:String){
        //TODO : 성공하면 set alarm , 버튼 취소로 바꾸기
        DispatchQueue.global(qos: .userInitiated).async {
            
            do{
            
            //요청할 url
            var components = URLComponents(string: "http://54.203.113.95/updateWashListForJson.php")
            
//            print("요청",String(washer_num))
//            print("요청",String(washer_time))
//            print("요청",String(self.emirim_id))
//            print("요청",String(isInsert))
            
            //요청변수
            components?.queryItems = [
                URLQueryItem(name: "washer_num", value: String(washer_num)),
                URLQueryItem(name: "wash_time", value: String(washer_time)),
                URLQueryItem(name: "emirim_id", value: self.emirim_id),
                URLQueryItem(name: "isInsert", value: isInsert),
                
            ]
            
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
                        
                        
                        if let return_data =  json["return_code"] as? [[String: Any]]{
                            print("리턴 데이터 : ",return_data);
                            for return_data_item in return_data {
                                
                                let return_code : Int = return_data_item["return_code"]! as! Int
                                
                                
                                // let _ : String = return_data_item["return_message"] as! String
                                if return_code == 1 {
                                 //   self.applyButton.titleLabel?.text = "취 소"
                                    self.showAlert(title: "세탁 신청에 성공했습니다.", message: "선택하신 요청이 성공적으로 끝났습니다.")
                                    self.initTimeTable()
                                }else if return_code == 2{
                                  //  self.applyButton.titleLabel?.text = "신 청"
                                    self.showAlert(title: "세탁 취소에 성공했습니다.", message: "선택하신 요청이 성공적으로 끝났습니다.")
                                    self.initTimeTable()
                                }else{
                                    self.showAlert(title: "세탁 신청에 실패했습니다.", message: "다시 시도해주세요.")
                                    self.initTimeTable()
                                }
                            }//for
                            
                        }//return_data
                        
                    }//ui updating
                    
                } catch {
                    print("error")
                    self.showAlert(title: "세탁 신청에 실패했습니다.", message: "다시 시도해주세요.")
                }
            })
            
            task.resume()
            }catch{
                self.showAlert(title: "네트워크가 불안정합니다.", message: "다시 시도해주세요.")

            }
        }
    }
}
