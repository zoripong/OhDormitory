//
//  ScoreViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 10..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    var scores = [Score]()
    var userScores = [UserScore]()
    
    @IBOutlet weak var scoreTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScoreViewController~")
        
        self.scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        
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
        
        
        
        print("scoreTable.count = \(userScores.count)")
        //scoreTable.reloadData()
        print("scoreTable.count = \(userScores.count)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("scoreViewController!")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userScores.count
    }
    
    // 셀 생성과 반환 - 필수 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userScores.count < 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            cell.date.text = "정보 없음"
            return cell
            
        }else{
            let cell = self.scoreTable.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath as IndexPath) as! ScoreCell
            
            let row: Int = indexPath.row
            print("row\(row)")
            
            if let dateLabel = cell.date{
                dateLabel.text = self.userScores[row].date
            }
            let score_id = userScores[row].score_id
            if let detailLabel = cell.detail{
                detailLabel.text = self.scores[score_id].detail
                print("detail\(self.scores[score_id].detail)")
            }
            if let scoreLabel = cell.date{
                scoreLabel.text = "\(self.scores[score_id].score)"
            }
            
            return cell
        }
        
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
                                let id = user_score_data_item["id"] as! String
                                let score_id = user_score_data_item["score_id"] as! String
                                let date = user_score_data_item["date"] as! String
                                
                                
                                self.userScores.append(UserScore(id: Int(id)!, date: date, score_id: Int(score_id)!))
                                
                                //                                if score < 0 {
                                //                                    minus_score = minus_score! + score
                                //                                }else{
                                //                                    plus_score = plus_score! + score
                                //                                }
                                
                            }
                            
                            print("minus : \(String(describing: minus_score))")
                            print("plus : \(String(describing: plus_score))")
                            print("scoreTable.count = \(self.userScores.count)")
                            DispatchQueue.main.async (execute:{()->Void in
                                self.scoreTable?.reloadData()
                            })
                            
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

