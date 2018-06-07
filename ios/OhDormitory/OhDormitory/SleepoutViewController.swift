//
//  SleepoutViewController.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 8..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class SleepoutViewController: UIViewController {

    struct Return_code : Codable{
        let return_code : Int
        let return_message : String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "http://54.203.113.95/getSleepoutList.php")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            // print(response!)
            do {
                
                
                var return_code = [String]()
                
                var return_message = [String]()
                
                
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                
                if let return_data =  json["return_code"] as? [[String: Any]]{
                    print(return_data);
                    for return_data_item in return_data {
                        
                        return_code.append("\(String(describing: return_data_item["return_code"]!))" )
                        
                        return_message.append(return_data_item["return_message"] as! String)
                        
                        
                    }
                    print(return_code)
                    print(return_message)
                    
                    
                }
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  

}
