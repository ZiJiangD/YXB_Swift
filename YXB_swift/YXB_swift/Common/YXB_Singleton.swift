//
//  WSJ_Singleton.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/23.
//  Copyright © 2017年 NightOwl. All rights reserved.
//
import UIKit
import Foundation



final class YXB_Singleton : NSObject{
    
    static let sharedInstance = YXB_Singleton()
    
    //用户信息
    private var userInfo : UseInfoModel?
    //系统信息
    private var sysReq : SystemParameterModel?
    
    
    private override init() {
        userInfo = UseInfoModel()
        sysReq = SystemParameterModel()
        
    }
    
    
    /// 获取系统参数模型
    ///
    /// - Returns: 系统参数模型
    func getSysReqModel() -> SystemParameterModel {
        
        return sysReq!
    }
    /// 获取用户参数模型
    ///
    /// - Returns: 用户参数模型
    func getUserInfoModel() -> UseInfoModel {

        return userInfo!
    }
    
    /// 设置/更新系统参数
    ///
    /// - Parameter sysReqModel: 系统参数模型
    func setSysReqModel(sysReqModel: SystemParameterModel) -> Void {
        
         sysReq = sysReqModel
    }
    /// 设置/更新用户参数
    ///
    /// - Parameter userInfoModel: 用户参数模型
    func setUserInfoModel(userInfoModel: UseInfoModel) -> Void {
        
         userInfo = userInfoModel
    }
    
}
