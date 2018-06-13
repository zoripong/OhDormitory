//
//  NoticeTableViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class NoticeTableViewController: UITableViewController {
    var notices = [Notice]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // get User Data
        //let defaults = UserDefaults.standard
        //let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
        // key ["emirim_id", "password", "name", room_num, "student_phone", "parent_phone"] ..
        print("NoticeTableViewController~")
        
        //self.scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        
        var request = URLRequest(url: URL(string: "http://54.203.113.95/getNotice.php")!)
        request.httpMethod = "POST"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                if let notice_data = json["notice"] as? Dictionary<String, AnyObject>{
                    print(notice_data.keys)
                    for key in notice_data.keys{
                        
                        if let notice_data_item =  notice_data[key] as? Dictionary<String, AnyObject>{
                            
                            let notice_id = notice_data_item["notice_id"] as! String
                            let title = notice_data_item["title"] as! String
                            let type = notice_data_item["type"] as! String
                            let w_time = notice_data_item["w_time"] as! String
                            let d_time = notice_data_item["d_time"] as! String
                            
                            switch type {
                            case "0":
                                print("기본공지")
                                if let notice_data_detail = notice_data_item["detail"] as? Dictionary<String, AnyObject>{
                                    let content = notice_data_detail["content"] as! String
                                    self.notices.append(BasicNotice(notice_id: Int(notice_id)!, title: title, type: Int(type)!, w_time: w_time, d_time: d_time, content: content))
                                }
                            case "1":
                                print("청소공지")
                                if let detail = notice_data_item["detail"] as? [String]{
                                    self.notices.append(CleanNotice(notice_id: Int(notice_id)!, title: title, type: Int(type)!, w_time: w_time, d_time: d_time, detail: detail))
                                    
                                }
                            case "2":
                                print("외박공지")
                                if let notice_data_detail = notice_data_item["detail"] as? Dictionary<String, AnyObject>{
                                    let application_deadline = notice_data_detail["application_deadline"] as! String
                                    let sleep_w_time = notice_data_detail["sleep_w_time"] as! String
                                    let sleep_d_time = notice_data_detail["sleep_d_time"] as! String
                                    let send = notice_data_detail["send"] as! String
                                    
                                    self.notices.append(SleepoutNotice(notice_id: Int(notice_id)!, title: title, type: Int(type)!, w_time: w_time, d_time: d_time, application_deadline: application_deadline, sleep_w_time: sleep_w_time, sleep_d_time: sleep_d_time, send: Int(send)!))
                                }
                            default:
                                print("default")
                                
                            }// end of switch
                            
                        }// end of if
                        
                        
                    }// end of for
                    DispatchQueue.main.async (execute:{()->Void in
                        self.noticeTable?.reloadData()
                    })
                }
                
                
                
                //print(notice_data)
                //                if let notice_data =  json["notice"] as? [[String: Any]]{
                //                    print(notice_data);
                //
                //                    //var i:Int = 0;
                //
                //                    for notice_data_item in notice_data {
                //                        print(notice_data_item)
                //                        /*
                //                        let detail = score_data_item["detail"] as! String
                //                        let score =  score_data_item["score"] as! String
                //                         */
                //                    }
                //                }
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
        
    }
    @IBOutlet var noticeTable: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath as IndexPath) as! NoticeCell
        
        if notices.count<0{
            cell.w_time.text = "정보없음"
        }else{
            let row: Int = indexPath.row
            print("row\(row)")
            
            if let wTimeLabel = cell.w_time{
                wTimeLabel.text = self.notices[row].w_time
            }
            
            if let dTimeLabel = cell.d_time{
                dTimeLabel.text = self.notices[row].d_time
            }
            
            if let titleLabel = cell.title{
                titleLabel.text = self.notices[row].title
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let type:Int = notices[indexPath.row].type
        if type == 0 || type == 1{
            let tmpBN = NoticeDetailViewController.init()
            tmpBN.noticeTitle = self.notices[indexPath.row].title
            tmpBN.noticeType = self.notices[indexPath.row].type
            tmpBN.w_time = self.notices[indexPath.row].w_time
            tmpBN.d_time = self.notices[indexPath.row].d_time
            if type == 0{
                let notice : BasicNotice = self.notices[indexPath.row] as! BasicNotice
                print("basic notice")
                tmpBN.content = notice.content
            }else if type == 1{
                let notice : CleanNotice = self.notices[indexPath.row] as! CleanNotice
                print("clean notice")
                tmpBN.cleanDetails = notice.detail
            }
            tmpBN.view.frame = self.view.bounds
            self.navigationController?.pushViewController( tmpBN, animated: true )
        }else if type == 2 {
            print("sleepout notice")
            //TODO : DOORI
        }
        
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "basicNotice"{
    //            if let vc = segue.destination as? BasicNoticeViewController{
    //
    //                vc.noticeTitle = "gd"
    //                vc.content = "content"
    //                vc.w_time = "2018-06-12"
    //                vc.d_time = "2018-06-13"
    //            }
    //        }
    //    }
    
}
