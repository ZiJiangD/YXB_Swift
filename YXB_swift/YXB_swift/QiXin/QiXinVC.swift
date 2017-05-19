//
//  QiXinVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QiXinVC: FirstBaseVC {

    
    var messageBtn: Button_S_1?
    var contactsBtn: Button_S_1?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = titleBarButtonItem()
        onClickNavTitleViewButton(messageBtn!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func titleBarButtonItem() -> UIView  {
        let backView: UIView = UIView()
        backView.frame = CGRect(x: 0.0, y: 0.0, width: SCREENWIDTH/3.0, height: 30.0)
        messageBtn = Button_S_1()
        messageBtn?.frame = CGRect(x: spaceSeparatorHeight, y: 0.0, width:( backView.frame.size.width-3*spaceSeparatorHeight)/2.0, height: backView.frame.size.height)
        messageBtn?.myTitleStr = "消息"
        messageBtn?.addTarget(self, action: #selector(onClickNavTitleViewButton(_:)), for: UIControlEvents.touchUpInside)
        
        contactsBtn = Button_S_1()
        contactsBtn?.frame = CGRect(x: (messageBtn?.frame.maxX)!+spaceSeparatorHeight, y: 0.0, width:( backView.frame.size.width-3*spaceSeparatorHeight)/2.0, height: backView.frame.size.height)
        contactsBtn?.myTitleStr = "通讯录"
        contactsBtn?.addTarget(self, action: #selector(onClickNavTitleViewButton(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        backView.addSubview(messageBtn!)
        backView.addSubview(contactsBtn!)
        
        return backView;
    }
    
    func onClickNavTitleViewButton(_ sender : Button_S_1) {
        if sender == messageBtn {
            contactsBtn?.isSelected=false;
            messageBtn?.isSelected=true;
            self.view.addSubview(self.messageView)            
        }else{
            messageBtn?.isSelected=false;
            contactsBtn?.isSelected=true;
            self.view.addSubview(self.contactsView)
        }
    }
    
    

    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    

    
    lazy var messageView: QX_MessageView = {
        var tempView : QX_MessageView = QX_MessageView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT-64-49))
        tempView.backgroundColor = UIColor.gray
        tempView.unReadCount_Block = {[weak self] (unReadTotalCount)->Void in
            if unReadTotalCount > 0{
                self?.messageBtn?.isShowBadge=true
            }else{
                self?.messageBtn?.isShowBadge=false
            }
        }
        return tempView
    }()
    lazy var contactsView: QX_ContactsView = {
        var tempView : QX_ContactsView = QX_ContactsView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT-64-49))
        tempView.backgroundColor = UIColor.lightGray
        return tempView
    }()
    

    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
