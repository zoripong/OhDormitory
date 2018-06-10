//
//  TabViewController.swift
//  OhDormitory
//
//  Created by Student on 2018. 6. 9..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    // @IBOutlet weak var myTab: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItems()
        viewWillLayoutSubviews()
        
    }
    
    override func viewWillLayoutSubviews() {
        //tabBar 높이 변경
        var newTabBarFrame = tabBar.frame
        
        let newTabBarHeight: CGFloat = 80
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newTabBarFrame
    }
    
    
    
    func setTabBarItems(){
        //tabBar 이미지
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "tab1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "tab1")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem1.title = ""
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "tab2")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "tab2")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem2.title = ""
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "tab3")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "tab3")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        myTabBarItem3.title = ""
        myTabBarItem3.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
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
