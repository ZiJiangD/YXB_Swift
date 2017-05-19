//
//  QX_ContactsInfoVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/8.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_ContactsInfoVC: SecondBaseVC {

    var infoView : QX_ContactsInfoView?
    
    var infoModel: QX_ContactsListInfoModel?{
        didSet{
            if infoView != nil {
                infoView?.model = infoModel
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title="联系人"
        let infoView = QX_ContactsInfoView.newLoginView()
        infoView?.frame = CGRect(x: 0, y: 64.0, width: SCREENWIDTH, height: SCREENHEIGHT-64.0)
        self.view.addSubview(infoView!)
        infoView?.model = infoModel
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
