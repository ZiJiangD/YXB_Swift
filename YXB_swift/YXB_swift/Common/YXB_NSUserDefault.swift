//
//  WSJ_NSUserDefault.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/23.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import HandyJSON

let UserDefault_SAVE_LOGIN_INFO_KEY = "LogInUserInformationModel"
class YXB_NSUserDefault: NSObject {

    
    /// 写入/更新用户信息
    ///
    /// - Parameter useInfomodel: 用户信息模型
    class func saveOrModifyLoginUserInformation(mobile:String ,password:String) -> Void {
        delog("saveOrModifyLoginUserInformation")
        let userDefault : UserDefaults = UserDefaults.standard
        
        let logInfo :[String:String] = ["mobile":mobile,"password":password]
        
        userDefault.set(logInfo, forKey: UserDefault_SAVE_LOGIN_INFO_KEY)
        userDefault.synchronize();
    }
    
    
    /// 读取用户信息
    ///
    /// - Returns: 用户信息模型
    class func readLoginUserInformation() -> [String:String] {
        delog("readLoginUserInformation")
        let userDefault : UserDefaults = UserDefaults.standard
        
        let logInfo = userDefault.value(forKey: UserDefault_SAVE_LOGIN_INFO_KEY) as? [String:String]
        if logInfo != nil {
            return logInfo!
        }else{
            return Dictionary<String,String>()
        }
    }
    
    
    /// 删除用户信息
    class func deleteLoginUserInformation() -> Void {
        delog(readLoginUserInformation)
       YXB_NSUserDefault.saveOrModifyLoginUserInformation(mobile: "", password: "")
    }
    
}
