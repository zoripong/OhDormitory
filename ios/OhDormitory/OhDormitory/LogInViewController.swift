//
//  LogInViewController.swift
//  OhDormitory
//
//  Created by Student on 2018. 6. 7..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

extension UITextField{
    func addBorderBottom(height:CGFloat, color:UIColor){
        let border=CALayer()
        border.frame=CGRect(x:0, y:self.frame.height-height,width:self.frame.width+self.frame.height,height:height)
        border.backgroundColor=color.cgColor
        self.layer.addSublayer(border)
    }
}

class LogInViewController: UIViewController, UITextFieldDelegate {
    var users = [User]()
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var pwText: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textfield border
        emailText.delegate = self
        
        let defaults = UserDefaults.standard
        let password = defaults.string(forKey: "password") ?? "Unknown user"
        print("패스워드는?? : \(password)")
        if password != "Unknown user"{
            performSegue(withIdentifier: "signOK", sender: self)
        }
        let emirim_id = defaults.string(forKey: "emirim_id") ?? "Unkown user"
        if emirim_id != "Unknown user"{
            emailText.text = emirim_id
        }
        
        pwText.text = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        emailText.placeholder="email";
        emailText.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        pwText.placeholder="PW";
        pwText.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        //textfield padding
        let indentView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        pwText.leftView = indentView2
        
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        emailText.leftView = indentView
        
        emailText.leftViewMode = .always
        pwText.leftViewMode = .always
        // -------------------------------------
        //var myUserInfo : User? // nil 로 초기화
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = [User]()
        var request = URLRequest(url: URL(string: "http://dorm.emirim.kr/getUsers.php")!)
        request.httpMethod = "POST"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                if let user_data =  json["user"] as? [[String: Any]]{
                    print(user_data);
                    for user_data_item in user_data {
                        let emirim_id = user_data_item["emirim_id"] as! String
                        let password = user_data_item["password"] as! String
                        let name =  user_data_item["name"] as! String
                        let room_num = user_data_item["room_num"] as! String
                        let student_phone = user_data_item["student_phone"] as! String
                        let parent_phone = user_data_item["parent_phone"] as! String
                        
                        self.users.append(User(emirim_id: emirim_id, password: password, name: name, room_num: Int(room_num)!, student_phone: student_phone, parent_phone: parent_phone))
                        
                    }
                    
                }
                
            } catch {
                print("error")
            }
        })
        
        
        //        performSegue(withIdentifier: "signOK", sender: self)
        task.resume()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClick(_ sender: Any) {
        
        let inputEmail = emailText.text
        let inputPw = pwText.text
        
        for user in self.users{
            if inputEmail == user.emirim_id && inputPw == user.password{
                
                let defaults = UserDefaults.standard
                defaults.set(user.emirim_id, forKey: "emirim_id")
                defaults.set(user.password, forKey: "password")
                defaults.set(user.room_num, forKey: "room_num")
                defaults.set(user.name, forKey: "name")
                defaults.set(user.student_phone, forKey: "student_phone")
                defaults.set(user.parent_phone, forKey: "parent_phone")
                
                //  Save to disk
                let didSave = defaults.synchronize()
                
                if !didSave {
                    //  Couldn't save (I've never seen this happen in real world testing)
                    print("\(inputEmail) != \(user.password)")
                }else{
                    self.pwText.text = ""
                    performSegue(withIdentifier: "signOK", sender: self)
                }
                
                
                
                
            }
            
        }
        
        let alert = UIAlertController(title: "로그인 실패", message: "해당하는 계정정보가 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
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
