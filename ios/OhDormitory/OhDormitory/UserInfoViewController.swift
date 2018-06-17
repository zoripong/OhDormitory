//
//  UserInfoViewController.swift
//  OhDormitory
//
//  Created by 장명수 on 2018. 6. 9..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class UserInfoViewController:UITableViewController{
    
    @IBOutlet weak var profil: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserInfoViewController~")
        self.profil.layer.borderWidth = 10
        self.profil.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1).cgColor
        profil.layer.cornerRadius = profil.frame.size.width/2
        profil.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // your code
        print("click cell")
        
        switch indexPath.row {
        case 0:
            print("상벌점")
            performSegue(withIdentifier: "ScoreView", sender: self)
        case 1:
            print("비밀번호 변경")
            performSegue(withIdentifier: "UpdatePassword", sender: self)
        case 2:
            print("로그아웃")
            let defaults = UserDefaults.standard
            
            var password = defaults.string(forKey: "password") ?? "Unknown user"
            print("패스워드는?? : \(password)")
            
            defaults.removeObject(forKey: "password")
            
            password = defaults.string(forKey: "password") ?? "Unknown user"
            print("패스워드는?? : \(password)")
            self.presentingViewController?.dismiss(animated: false, completion:nil)
        //performSegue(withIdentifier: "LogOut", sender: self)
        default:
            print("default")
            
        }
    }
    
}
