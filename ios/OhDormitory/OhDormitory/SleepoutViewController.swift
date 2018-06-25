//
//  SleepoutViewController.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 8..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit
import MobileCoreServices

class SleepoutViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var recognizeLabel: UILabel!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    
    struct Return_code : Codable{
        let return_code : Int
        let return_message : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("SleepoutViewController가 시작되었어요!");
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Download file or perform expensive task
            
            //요청할 url
            var components = URLComponents(string: "https://dorm.emirim.kr/getSleepoutRecord.php")
            //요청변수
            
            // get User Data
            let defaults = UserDefaults.standard
            let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
            
           // print("이거"+emirim_id)
           // print("이거"+parent_phone)
            
            components?.queryItems = [
                URLQueryItem(name: "userID", value: emirim_id)
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
                                let return_message : String = return_data_item["return_message"] as! String
                                if(return_code == 2){
                                    self.getSleepoutInfo(json: json,message : return_message)
                                }else{
                                    self.setSleepoutInfo(message :return_message)
                                }
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
    func getSleepoutInfo(json : Dictionary<String, AnyObject>,message:String){
        if let notice_data =  json["notice"] as? [[String: Any]]{
            print("notice : ",notice_data)
            var notice_data_item = notice_data[0]
            
            if let record_data =  json["record"] as? [[String: Any]]{
                var record_data_item = record_data[0]
                let recognize : String = record_data_item["recognize"]! as! String
                
                self.setSleepoutInfo(isRecognize: recognize,sleep_w_time: notice_data_item["sleep_w_time"] as! String,sleep_d_time: notice_data_item["sleep_d_time"] as! String)
            }
            
        }
    }
    
    func setSleepoutInfo(isRecognize : String, sleep_w_time:String, sleep_d_time:String){
        
        var recognize : String = ""
        
        if(isRecognize=="0"){
            recognize="미인증"
        }
        else{
            recognize="인증완료"
        }
        
        // print(recognize)
        // print(sleep_w_time)
        // print(sleep_d_time)
        
        self.dateLabel.text=sleep_w_time+" ~ "+sleep_d_time
        //TODO: 번호 넣기
        let defaults = UserDefaults.standard
        let parent_phone = defaults.string(forKey: "parent_phone") ?? "Unknown user"

        self.phoneLabel.text="인증 연락처 : "+parent_phone
        self.messageLabel.text=""
        self.recognizeLabel.text=recognize
        self.cameraButton?.isHidden = true
        
        
    }
    
    func setSleepoutInfo(message : String){
        print(message)
        self.dateLabel.text=""
        self.phoneLabel.text=""
        
        self.messageLabel.text=message
        self.recognizeLabel.text=""
        self.cameraButton?.isHidden = true
        
    }
    
    
}

