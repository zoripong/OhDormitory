//
//  UpdatePasswordViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 12..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    
    var emirim_id:String = ""
    var password:String = ""
    var newPassword : String = ""
    @IBOutlet weak var nowPwField: UITextField!
    @IBOutlet weak var changePwField: UITextField!
    @IBOutlet weak var rePwField: UITextField!
    @IBAction func doneBtn(_ sender: UIButton) {
        let nowInputPw:String? = nowPwField.text
        let changePw:String? = changePwField.text
        let rePw:String? = rePwField.text
        
        if password != "Unknown user" && password != ""{
            if nowInputPw == password{
                // 비밀번호 변경
                if changePw == rePw{
                    // 비밀번호 변경
                    newPassword = changePw!
                    self.updatePassword()
                }else{
                    // 비밀번호가 동일하지 않음
                    let alert = UIAlertController(title: "변경 실패", message: "변경 비밀번호가 동일하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                //입력 비밀번호가 틀림
                let alert = UIAlertController(title: "변경 실패", message: "현재 비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            // 에러
            let alert = UIAlertController(title: "변경 실패", message: "계정정보를 로드하는데 문제가 발생하였습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        password = defaults.string(forKey: "password") ?? "Unknown user"
        emirim_id = defaults.string(forKey: "emirim_id") ?? "Unknown user"
        
        
        //텍스트필드 커스텀
        nowPwField.placeholder="현재 비밀번호";
        nowPwField.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        changePwField.placeholder="변경 비밀번호";
        changePwField.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        rePwField.placeholder="재입력";
        rePwField.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        
        //textfield padding
        let indentView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        changePwField.leftView = indentView2
        
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        nowPwField.leftView = indentView
        
        let indentView3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        rePwField.leftView = indentView3
        
        nowPwField.leftViewMode = .always
        changePwField.leftViewMode = .always
        rePwField.leftViewMode = .always
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updatePassword(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Download file or perform expensive task
            //요청할 url
            var components = URLComponents(string: "https://dorm.emirim.kr/updateUserData.php")
            //요청변수
            components?.queryItems = [
                URLQueryItem(name: "emirim_id", value: self.emirim_id),
                URLQueryItem(name: "password", value: self.password),
                URLQueryItem(name: "new_password", value : self.newPassword)
            ]
            
            guard let url = components?.url else { return }
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) {
                (data: Data?, response: URLResponse?, error: Error?) in
                
                if(error != nil) {
                    print("Error: \(String(describing: error))")
                }else
                {
                    
                    let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String?
                    //send this block to required place
                    print(outputStr ?? "nil")
                }
            }
            
            
            task.resume()
            DispatchQueue.main.async (execute:{()->Void in
                let alert = UIAlertController(title: "변경 완료", message: "성공적으로 비밀번호가 변경되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            })
            
            
            
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
