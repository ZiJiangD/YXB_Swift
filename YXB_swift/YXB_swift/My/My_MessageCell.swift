//
//  QX_MessageCell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/5.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class My_MessageCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subTitleLab: UILabel!
    @IBOutlet weak var LookInfoBtn: UIButton!
    
    let infoVC:EdithAndDetailMyInfoVC = EdithAndDetailMyInfoVC()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessageCellUI(title:String,subTitle:String,logoImageStr:String) {
        
        let url :URL? = URL(string: logoImageStr)
        self.logoImage.sd_setImage(with: url, placeholderImage: UIImage(named: "toux"))
        self.titleLab.text = title
        self.subTitleLab.text = subTitle
        
        
    }
    @IBAction func onClickInfoButton(_ sender: UIButton) {
        
        Common.currentViewController()?.navigationController?.pushViewController(infoVC, animated: true)
    }
    func setScanCellUI(title:String,subTitle:String,logoImageStr:String) {
        
        let url :URL? = URL(string: logoImageStr)
        self.logoImage.sd_setImage(with: url, placeholderImage: UIImage(named: "toux"))
        self.titleLab.text = title
        self.subTitleLab.text = subTitle
        self.LookInfoBtn.isHidden = true
        
        
    }
}
