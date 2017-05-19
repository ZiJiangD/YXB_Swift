//
//  My_BusinessCardVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/17.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class My_BusinessCardVC: SecondBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "名片二维码"
        self.view.backgroundColor=UIColor.darkGray
        showView()
    }


    
    func showView() {
        let W_H : CGFloat = SCREENWIDTH - 8*spaceSeparatorHeight
        let showView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: W_H, height: W_H))
        showView.center = self.view.center;
        showView.backgroundColor=UIColor.white
        showView.layer.cornerRadius = 4.0
        showView.layer.masksToBounds = true
        
        
        //logoImageV
        
        let logoImageV:UIImageView = UIImageView(frame: CGRect(x: 2*spaceSeparatorHeight, y: 2*spaceSeparatorHeight, width: 60, height: 60))
        let url :URL? = URL(string: YXB_Singleton.sharedInstance.getUserInfoModel().headImg )
        logoImageV.sd_setImage(with: url, placeholderImage: UIImage(named: "toux"))
        logoImageV.layer.cornerRadius=4.0
        logoImageV.layer.masksToBounds=true
        showView.addSubview(logoImageV)
        
        
        let nameLab = UILabel(frame: CGRect(x: logoImageV.frame.maxX+2*spaceSeparatorHeight, y: logoImageV.frame.minY+5, width: W_H-4*spaceSeparatorHeight - logoImageV.frame.size.width, height: 25))
        nameLab.text=YXB_Singleton.sharedInstance.getUserInfoModel().realName
        nameLab.font = kFONT15
        showView.addSubview(nameLab)
        
        let cpLab = UILabel(frame: CGRect(x: nameLab.frame.minX, y: nameLab.frame.maxY, width: nameLab.frame.width, height: 25))
        cpLab.text=YXB_Singleton.sharedInstance.getUserInfoModel().enterpriseName
        cpLab.textColor = UIColor.lightGray
        cpLab.font = kFONT15
        showView.addSubview(cpLab)
        
        
        let backImageV=UIImageView(frame: CGRect(x: (W_H-160.0)/2.0, y: logoImageV.frame.maxY+4*spaceSeparatorHeight, width: 160.0, height: 160.0))
        backImageV.image=UIImage(named: "erweima_border")
        showView.addSubview(backImageV)
        
        let cardImageV=UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 140.0, height: 140.0))
        cardImageV.center=backImageV.center

        let cardurl :URL? = URL(string: YXB_Singleton.sharedInstance.getUserInfoModel().tdcImg ?? "" )
        cardImageV.sd_setImage(with: cardurl, placeholderImage: UIImage(named: "toux"))
        showView.addSubview(cardImageV)
        
        let extractLab = UILabel(frame: CGRect(x: spaceSeparatorHeight, y: backImageV.frame.maxY+spaceSeparatorHeight, width: W_H-2*spaceSeparatorHeight, height: 25))
        extractLab.text="扫一扫二维码，扩展生意圈"
        extractLab.font = kFONT12
        extractLab.textColor = UIColor.lightGray
        extractLab.textAlignment = .center
        showView.addSubview(extractLab)
        
        
        self.view.addSubview(showView)
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
