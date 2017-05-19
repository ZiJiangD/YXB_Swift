//
//  QX_ContactsModel.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/5.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import HandyJSON


struct QX_ContactsOrgModel: HandyJSON{
    var id : String?
    var level : String?
    var name : String?
    var orgUserTotal : String?
    var pid : String?
}

struct QX_ContactsListInfoModel: HandyJSON{
    var accountType : String?
    var createTime : String?
    var easemobUser : String?
    var enabled : String?
    var headImg : String?
    var id : String?
    var mobile : String?
    var orgId : String?
    var orgName : String?
    var positionName : String?
    var userId : String?
    var usersName : String?
}
struct QX_ContactsDataModel: HandyJSON{
    var usersList : [QX_ContactsListInfoModel]=Array()//全部通讯录
    
    ///按组织架构查询
    var orgUserTotal :String = "0"
    var orgs:[QX_ContactsOrgModel]=Array()//组织
    
    
    var users :[QX_ContactsListInfoModel]=Array()//不属于任何部门的
    
    
}
struct QX_ContactsModel: HandyJSON{
    var msg: String?
    var code: String?
    var data : QX_ContactsDataModel = QX_ContactsDataModel()
}
