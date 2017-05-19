//
//  UseInfoModel.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import HandyJSON

struct UseInfoModel: HandyJSON {
    var accessToken : String?
    var accountType : String?
    var easemobUser : String?
    var email : String?
    var enterpriseId : String?
    var enterpriseName : String?
    var gender : String?
    var headImg : String=""
    var id : String?
    var isOrgAdmin : String?
    var isOrgPrincipal : String?
    var mobile : String?
    var orgId : String?
    var orgName : String?
    var positionId : String?
    var positionName : String?
    var realName : String?
    var remark : String?
    var tdcImg : String?
    var url : String?
    var warnMsg : String?
    
}


struct UseModel: HandyJSON {
    var msg: String?
    var code: String?
    var data : UseInfoModel?
    
}
