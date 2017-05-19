//
//  CustomDefine.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import UIKit





//TODO:颜色

/// 主色
let YXBMainColor : UIColor = UIColor.color(withHexString: "38373c", alpha: 1)
let navigationBarColor: UIColor =  UIColor.color(withHexString: "#38373c")
let tabBarColor: UIColor =  UIColor.color(withHexString: "#3BA7EE")
let spaceSeparatorColor : UIColor = UIColor.color(withHexString: "f5f5f9", alpha: 1)

//TODO:高宽度
let SCREENHEIGHT = UIScreen.main.bounds.size.height
let SCREENWIDTH = UIScreen.main.bounds.size.width
let spaceSeparatorHeight = CGFloat(6.0)

//FIXME:字体


let kFONT20 = UIFont.systemFont(ofSize: 20.0)
let kFONT19 = UIFont.systemFont(ofSize: 19.0)
let kFONT18 = UIFont.systemFont(ofSize: 18.0)
let kFONT17 = UIFont.systemFont(ofSize: 17.0)
let kFONT16 = UIFont.systemFont(ofSize: 16.0)
let kFONT15 = UIFont.systemFont(ofSize: 15.0)
let kFONT14 = UIFont.systemFont(ofSize: 14.0)
let kFONT13 = UIFont.systemFont(ofSize: 13.0)
let kFONT12 = UIFont.systemFont(ofSize: 12.0)
let kFONT11 = UIFont.systemFont(ofSize: 11.0)
let kFONT10 = UIFont.systemFont(ofSize: 10.0)

let BOLD_KFONT_11 = UIFont(name: "Helvetica-Bold", size: 11.0)
let BOLD_KFONT_12 = UIFont(name: "Helvetica-Bold", size: 12.0)
let BOLD_KFONT_13 = UIFont(name: "Helvetica-Bold", size: 13.0)
let BOLD_KFONT_14 = UIFont(name: "Helvetica-Bold", size: 14.0)
let BOLD_KFONT_15 = UIFont(name: "Helvetica-Bold", size: 15.0)
let BOLD_KFONT_16 = UIFont(name: "Helvetica-Bold", size: 16.0)
let BOLD_KFONT_17 = UIFont(name: "Helvetica-Bold", size: 17.0)
let BOLD_KFONT_18 = UIFont(name: "Helvetica-Bold", size: 18.0)
let BOLD_KFONT_19 = UIFont(name: "Helvetica-Bold", size: 19.0)
let BOLD_KFONT_20 = UIFont(name: "Helvetica-Bold", size: 20.0)
let BOLD_KFONT_25 = UIFont(name: "Helvetica-Bold", size: 25.0)






/// 请求通讯录 类型
enum ENUM_QX_AddressBook:Int {
    //如果指定类型为非Int类型，需要给每一个元素指定值，且每个值必须唯一
    case QX_Normal = 0 //0-查询正常用户
    case QX_OwnAndSubordinates //1-查询自己及下属
    case QX_All //2-查询全部
    case QX_Approval //3-审批
    case QX_Communication //4-及时通讯
}
/// 请求通讯录 类型 查询范围
enum ENUM_QX_AddressBook_Cope:Int {
    //如果指定类型为非Int类型，需要给每一个元素指定值，且每个值必须唯一
    case QX_All = 0 //0-全公司此时orgId为空
    case QX_Org //1-查询组织

}



/// 请求通讯录 类型 查询范围
enum ENUM_UPLOAD_PHOTO_MODULE:String {
    //如果指定类型为非Int类型，需要给每一个元素指定值，且每个值必须唯一
    case UPLOAD_ANNC_MODULE = "annc"
    case UPLOAD_VISIT_MODULE = "visit"
    case UPLOAD_WM_MODULE = "wm"
    case UPLOAD_PHOTO_MODULE = "photo"
    case UPLOAD_ATTEND_MODULE = "attend"
}
























/// 自定义输出
///
/// - Parameters:
///   - filePath: 文件名
///   - methodName: 方法名
///   - rowCount: 所在行数
func delog( filePath : String = #file, methodName:String = #function, rowCount : Int = #line ) -> Void {
    #if DEBUG
        let  fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print(fileName + "/" + methodName + "/" + "\(rowCount)" + "\n")
    #endif
}


/// 自定义输出（具体到 【[文件名/ 方法名/ 所在行/  messgae]】）
///
/// - Parameters:
///   - message: 输出的消息体
///   - filePath: 文件名
///   - methodName: 方法名
///   - rowCount: 所在函数
func delog<T>(_ message: T, filePath: String = #file, methodName:String = #function, rowCount: Int = #line) -> Void {
    #if DEBUG
        let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        print("[FileName:" + fileName + "/ MethodName:" + methodName + "/ RowCount:" +  "\(rowCount)" + "] \n" + " \(message)" + "\n")
    #endif
}
