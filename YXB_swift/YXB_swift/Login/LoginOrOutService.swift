//
//  LoginOrOutService.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class LoginOrOutService: NSObject {

    static func login(mobile:String, passWord:String , success: @escaping([String : Any]?) -> (),failure: @escaping(NSError?) -> ()) {
        var param : [String : String] = Dictionary()
        param["mobile"] = mobile
        param["password"] = PasswordControl.encodePassword(passWord)
        
        RequestSeverManager.YXB_Request_String(WithURLStr: LOGIN, andParameters: param, success: { (responseStr, responseDic) in
            
            let userModel : UseModel = UseModel.deserialize(from: responseStr)!
            if userModel.code == CODE_SUCCESS {
                YXB_Singleton.sharedInstance.setUserInfoModel(userInfoModel: userModel.data!)
                YXB_NSUserDefault.saveOrModifyLoginUserInformation(mobile: mobile, password: passWord)
            }else{
                String.showTost(userModel.msg)
            }
            success(responseDic)
            
        }) { (error) in
            failure(error)
        }
    }
    
}
