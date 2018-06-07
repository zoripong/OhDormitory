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

class LogInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //textfield border
        emailText.placeholder="";
        emailText.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        pwText.placeholder="PW";
        pwText.addBorderBottom(height: 1.5, color:UIColor.init(red:150/255.0, green: 181/255.0, blue: 195/255.0, alpha: 1.0))
        
        //textfield padding
        let indentView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        pwText.leftView = indentView2
        
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        emailText.leftView = indentView
        emailText.leftViewMode = .always
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
