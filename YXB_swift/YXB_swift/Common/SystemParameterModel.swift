//
//  SystemParameterModel.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/23.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

import HandyJSON

struct SystemParameterModel: HandyJSON {
    //操作系统
    var system : String?
    //手机唯一标识
    var imei : String?
    //当前客户端版本
    var currentVersion : String?
    //操作系统版本
    var systemVersion : String?
    //手机型号
    var model : String?
    //数字签名
    var sig : String?
    //接口版本号
    var inteVersion : String?
    
    
}
