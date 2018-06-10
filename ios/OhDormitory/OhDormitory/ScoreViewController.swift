//
//  ScoreViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 10..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var scores = [Score]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScoreViewController~")
        
        // load score list
        var request = URLRequest(url: URL(string: "http://54.203.113.95/getScore.php")!)
        request.httpMethod = "POST"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                if let score_data =  json["score"] as? [[String: Any]]{
                    print(score_data);
                    var i:Int = 0;
                    
                    for score_data_item in score_data {
                        let score_id:Int = i;
                        let detail = score_data_item["detail"] as! String
                        let score =  score_data_item["score"] as! String
                        
                        self.scores.append(Score(score_id: score_id, detail: detail, score: Double(score)!))
                        i+=1
                        
                    }
                    self.loadUserScore()
                }
                
            } catch {
                print("error")
            }
        })
        //        performSegue(withIdentifier: "signOK", sender: self)
        task.resume()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("scoreViewController!")
        
    }

    func loadUserScore(){
        
        // get User Data
        let defaults = UserDefaults.standard
        let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
        
        var minus_score : Double?
        var plus_score : Double?
        
        print(emirim_id)
        if(emirim_id == "Unknown user"){
            let alert = UIAlertController(title: "로그인 실패", message: "해당하는 계정정보가 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            //load score list
            var request = URLRequest(url: URL(string: "http://54.203.113.95/getUserScore.php")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    
                    if let score_data =  json["user_score"] as? Dictionary<String, AnyObject>{
                        print(score_data);
                        if let user_score_data = score_data[emirim_id] as? [[String: Any]]{
                            print(user_score_data);
                            for user_score_data_item in user_score_data{
                                print(user_score_data_item["date"] ?? "date")
                                let score_id = user_score_data_item["score_id"] as! String
                                let detail = self.scores[Int(score_id)!].detail
                                let score = self.scores[Int(score_id)!].score
                                
                                
//                                if score < 0 {
//                                    minus_score = minus_score! + score
//                                }else{
//                                    plus_score = plus_score! + score
//                                }
                                
                            }
                            print("minus : \(String(describing: minus_score))")
                            print("plus : \(String(describing: plus_score))")
                        }
                    }
                    
                } catch {
                    print("error")
                }
            })
            //        performSegue(withIdentifier: "signOK", sender: self)
            task.resume()
        }
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
