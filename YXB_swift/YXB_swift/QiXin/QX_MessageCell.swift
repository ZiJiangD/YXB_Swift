//
//  QX_MessageCell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/5.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_MessageCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var countLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        self.countLab.layer.cornerRadius = self.countLab.frame.size.width/2.0
        self.countLab.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessageCellUI(title:String,subTitle:String,countNumStr:String,logoImageStr:String) {
        self.logoImage.image = UIImage(named: logoImageStr)
        self.titleLab.text = title
        self.subTitleLab.text = subTitle
        
        if (Int(countNumStr)! > 0 ) {
            self.countLab.isHidden = false
            self.countLab.text = countNumStr
        }else{
            self.countLab.isHidden = true
        }
    }
    
}
