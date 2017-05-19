//
//  QX_ContactsInfoView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/8.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_ContactsInfoView: UIView {

    class func newLoginView() -> QX_ContactsInfoView? {
        let nibView = Bundle.main.loadNibNamed("QX_ContactsInfoView", owner: nil, options: nil)
        if let view = nibView?.first as? QX_ContactsInfoView{
            view.backgroundColor = spaceSeparatorColor
            return view;
        }
        return nil
        
    }
    
    
    var model:QX_ContactsListInfoModel?{
        didSet{
            let url :URL? = URL(string: model?.headImg ?? "")
            self.headImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "toux"))
            nameLab.text = model?.usersName
            positionLab.text = model?.positionName
            orgLab.text = model?.orgName
            mobileLab.text = model?.mobile
        }
    }
    
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var positionLab: UILabel!
    @IBOutlet weak var orgLab: UILabel!
    @IBOutlet weak var mobileLab: UILabel!
    
    @IBAction func onClickCallPhone(_ sender: Any) {
        String.callString(phoneNumStr: (model?.mobile ?? ""))
    }
    @IBAction func onClickChat(_ sender: Any) {
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
