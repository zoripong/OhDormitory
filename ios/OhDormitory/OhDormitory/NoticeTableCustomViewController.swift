//
//  NoticeTableCustomViewController.swift
//  OhDormitory
//
//  Created by Student on 2018. 6. 14..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTableView: UITableView {
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            if let image = backgroundImage {
                let backgroundImage = UIImageView(image: UIImage(named: "background"))
                backgroundImage.contentMode = UIViewContentMode.scaleToFill
                backgroundImage.clipsToBounds = false
                self.backgroundView = backgroundImage
            }
        }
    }
    
}
