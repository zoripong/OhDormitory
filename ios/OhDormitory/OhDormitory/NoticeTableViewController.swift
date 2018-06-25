//
//  NoticeTableViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 11..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

//TODO : doori 1
extension UIAlertController {
    
    func setMaxHeight(_ height: CGFloat) {
        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        view.addConstraint(constraint)
    }
    
}
//TODO : doori 1 닫음

class NoticeTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
//        var imageView = UIImageView(frame: CGRect(x:10, y:10, width:cell.frame.width - 10, height:cell.frame.height - 10))
//        let image = UIImage(named: "tab_background.jpg")
//        imageView.image = image
//        //Just add imageView as subview of cell
//        cell.addSubView(imageView)
//        cell.sendSubviewToBack(imageView)
//    }
        
        let imageView = UIImageView(frame: CGRect(x:15, y:20, width:cell.frame.width-30, height:cell.frame.height - 20))
        let image = UIImage(named: "cardview.png")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
    }
    
    var notices = [Notice]()
    
    //TODO : doori 2
    var sleeptype_choice = ["잔류","금요외박","토요외박"]
    var pickerView = UIPickerView()
    var typeValue = String()
    //TODO : doori 2 닫음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //table view custom
        let backgroundImage = UIImage(named: "tab_background.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        //tableView.tableFooterView = UIView(frame: CGRectZero)
        imageView.contentMode = .scaleAspectFit

        
     
        //tableView.tableFooterView = UIView(frame: CGRectZero)
        // get User Data
        //let defaults = UserDefaults.standard
        //let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
        // key ["emirim_id", "password", "name", room_num, "student_phone", "parent_phone"] ..
        print("NoticeTableViewController~")
        
        //self.scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "ScoreCell")
        
        var request = URLRequest(url: URL(string: "http://dorm.emirim.kr/getNotice.php")!)
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
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // translucent cell backgrounds so we can see the image but still easily read the contents
        
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
            //TODO : doori 3
            showSleepoutApplyAlert(sender: self,notice_id:notices[indexPath.row].notice_id,w_time:notices[indexPath.row].w_time,d_time:notices[indexPath.row].d_time)
            //TODO : doori 3 닫음

        }
        
        
    }
    
    //TODO : doori 4
    func showSleepoutApplyAlert(sender: Any?,notice_id:Int,w_time:String,d_time:String){
        let defaults = UserDefaults.standard
        let parent_phone = defaults.string(forKey: "parent_phone")
        
        var message : String = ""
        message += "날짜 : "+String(w_time)+" ~ "+String(d_time)+"\n"
        message += "보호자 연락처 : "+parent_phone!
        
        let alert = UIAlertController(title: "외박을 신청합니다.", message: message, preferredStyle: .alert)
        alert.isModalInPopover = true
        
        
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 55, width: 250, height: 100))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            //print("You selected " + self.typeValue )
            self.showConfirm(sleep_type : self.typeValue,notice_id:notice_id,w_time:w_time,d_time:d_time)
            
        }))
        
        alert.setMaxHeight(CGFloat(220.0))
        self.present(alert,animated: true, completion: nil )
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sleeptype_choice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sleeptype_choice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            typeValue = "잔류"
        } else if row == 1 {
            typeValue = "금요외박"
        } else if row == 2 {
            typeValue = "토요외박"
        }
    }
    func showConfirm(sleep_type:String,notice_id:Int,w_time:String,d_time:String){
        
        let message = w_time+" ~ "+d_time+"에 "+sleep_type+"를 신청합니다."
        let alert = UIAlertController(title: "외박일지를 제출하시겠습니까?", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: { action in
            let defaults = UserDefaults.standard
            let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
            self.applySleepout(notice_id:notice_id,emirim_id:emirim_id,sleep_type:sleep_type)
            
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func applySleepout(notice_id:Int,emirim_id:String,sleep_type:String){
        DispatchQueue.global(qos: .userInitiated).async {
            // Download file or perform expensive task
            
            //요청할 url
            var components = URLComponents(string: "http://dorm.emirim.kr/insertSleepoutRecordForJson.php")
            //요청변수
            components?.queryItems = [
                URLQueryItem(name: "notice_id", value: String(notice_id)),
                URLQueryItem(name: "emirim_id", value: emirim_id),
                URLQueryItem(name: "sleep_type", value: sleep_type),
                URLQueryItem(name: "recognize", value: "0")
                
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
                                if(return_code == 1){
                                    self.showAlert(title:"외박신청에 성공했습니다.",message:"요청이 성공적으로 끝났습니다.")
                                }else{
                                    self.showAlert(title:"외박신청에 실패했습니다.",message:"다시 시도해주세요.")
                                }
                            }//for
                            
                        }//return_data
                        
                    }//ui updating
                    
                } catch {
                    print("error")
                    self.showAlert(title:"외박신청에 실패했습니다.",message:"다시 시도해주세요.")
                }
            })
            
            task.resume()
        }
    }
    func showAlert(title:String,message:String){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //TODO : doori 4 닫음

    
}
