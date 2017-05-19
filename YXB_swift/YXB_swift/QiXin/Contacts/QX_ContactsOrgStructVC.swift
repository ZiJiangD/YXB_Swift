//
//  QX_ContactsOrgStructVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/9.
//  Copyright © 2017年 NightOwl. All rights reserved.
//


//按组织架构查看
import UIKit

class QX_ContactsOrgStructVC: SecondBaseVC {

    //组织级别
    var level:String?
    var scope:ENUM_QX_AddressBook_Cope?
    var org:String?
    var orgName:String? = "按组织架构查看"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title=orgName!
        
        self.view.backgroundColor=UIColor.green
        self.view.addSubview(self.contactsView)
        loadNewData()
        self.automaticallyAdjustsScrollViewInsets=false

    }

    
    
    func loadNewData() {
        
        if level == nil {
            level = "0"
        }
        if scope == nil {
            scope = .QX_All
        }
        
        QX_Service.getAddressBookGroupByOrg(type: .QX_Approval, level: level!, QueryScope: scope!, org: org, success: { (responSetr, responseDic) in
            delog(responseDic)
            let dataModel: QX_ContactsModel = QX_ContactsModel.deserialize(from: responSetr)!
            
           self.contactsView.dataModel=dataModel
            
            
        }) { (error) in
            delog(error)
        }
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
    
    lazy var contactsView: QX_ContactsOrgStructView = {
        var tempView : QX_ContactsOrgStructView = QX_ContactsOrgStructView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT-64))
        tempView.backgroundColor = spaceSeparatorColor
        return tempView
    }()

}
