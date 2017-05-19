//
//  ContactsDepartmentChooseCell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/8.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class ContactsDepartmentChooseCell: UICollectionViewCell {

    @IBOutlet weak var nextImageV: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var titleLabWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellUI(indexPath:IndexPath,title:String,islightColor:Bool) {
        if indexPath.row == 0 {
//            self.titleLabWidth.constant = 84
            self.nextImageV.isHidden = true
        }else{
//            self.titleLabWidth.constant = 71
            self.nextImageV.isHidden = false
        }
        self.titleLab.text = title
        if islightColor {
            self.titleLab.textColor = tabBarColor
        }else{
            self.titleLab.textColor = UIColor.black
        }
    }
    
}
