//
//  BaseModel.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import HandyJSON

// 物流信息 数据模型
struct BaseModel : HandyJSON {
    var msg: String?
    var code: String?
    var data : Any?
}
