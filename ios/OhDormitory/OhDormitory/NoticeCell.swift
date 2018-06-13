//
//  NoticeCell.swift
//  OhDormitory
//
//  Created by doori on 2018. 6. 14..
//  Copyright © 2018년 doori. All rights reserved.
//

import UIKit

class NoticeCell: UITableViewCell {

    @IBOutlet weak var w_time: UILabel!
    @IBOutlet weak var d_time: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
