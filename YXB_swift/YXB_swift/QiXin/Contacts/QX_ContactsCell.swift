//
//  QX_ContactsCell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/5.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_ContactsCell: UITableViewCell {

    @IBOutlet weak var logoImageV: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    /// 部门
    @IBOutlet weak var sectionLab: UILabel!
    @IBOutlet weak var mobileLab: UILabel!
    @IBOutlet weak var callPhoneBtn: UIButton!
    
    @IBOutlet weak var nameWidth: NSLayoutConstraint!
    @IBOutlet weak var sectionWidth: NSLayoutConstraint!
    
    
    
    var cellModel:QX_ContactsListInfoModel = QX_ContactsListInfoModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        callPhoneBtn.isUserInteractionEnabled=true
        mobileLab.textColor=UIColor.darkText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.layoutIfNeeded()
    }
    
    func setContactsCellUI(model:QX_ContactsListInfoModel) {
        self.layoutIfNeeded()

        cellModel=model
        
        let url :URL? = URL(string: model.headImg ?? "")
        logoImageV.sd_setImage(with: url, placeholderImage: UIImage(named: "toux"))

        
        
        nameLab.text = model.usersName
        sectionLab.text = model.orgName
        mobileLab.text = model.mobile
        let section_W : CGFloat = String.calculationWidth(withText: self.sectionLab.text, andFontSize: kFONT14.pointSize, andWithHeight: self.sectionLab.frame.size.height)
        
        let name_W : CGFloat = String.calculationWidth(withText: self.nameLab.text, andFontSize: kFONT15.pointSize, andWithHeight: self.nameLab.frame.size.height)
        if section_W+name_W > self.mobileLab.frame.size.width{
            if name_W > section_W {
                self.nameWidth.constant=self.mobileLab.frame.size.width-section_W
                self.sectionWidth.constant=section_W
            }else{
                self.nameWidth.constant=name_W
                self.sectionWidth.constant=self.mobileLab.frame.size.width-name_W
            }
        }else{
            self.nameWidth.constant=name_W
            self.sectionWidth.constant=section_W
        }
    }
    
    @IBAction func onClickCellButton(_ sender: UIButton) {
        String.callString(phoneNumStr: cellModel.mobile ?? "")
    }
    
    
    func setContactsOrgCellUI(model:QX_ContactsOrgModel) {
        logoImageV.image=UIImage(named: "qiXin_group")
        callPhoneBtn.setImage(UIImage(named:"next"), for: .normal)
        callPhoneBtn.isUserInteractionEnabled=false
        
        self.sectionWidth.constant = 0.0
        nameLab.text = model.name
        
        mobileLab.textColor = UIColor.lightGray
        mobileLab.text = model.orgUserTotal!+"人"
        let name_W : CGFloat = String.calculationWidth(withText: self.nameLab.text, andFontSize: kFONT15.pointSize, andWithHeight: self.nameLab.frame.size.height)
        if name_W > self.mobileLab.frame.size.width{
            nameWidth.constant = self.mobileLab.frame.size.width
        }else{
            nameWidth.constant = name_W
        }
        
    }
    
    
}
