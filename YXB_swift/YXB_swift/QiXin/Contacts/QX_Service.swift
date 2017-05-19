//
//  QX_Service.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/5.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_Service: NSObject {

    
    /// 请求企信 公告、通知、工作提醒、共享通知  各个 消息未读个数接口
    ///
    /// - Parameters:
    ///   - success: 成功
    ///   - failure: 失败
    class func getunReadCount(success: @escaping(String?,Dictionary <String , AnyObject>?) -> (),failure: @escaping(NSError?) -> ()) {
        var param : [String : String] = Dictionary()
        RequestSeverManager.YXB_Request_String(WithURLStr: QIXIN_UNREAD_COUNT, andParameters: param, success: { (responseStr, responseDic) in
            success(responseStr, responseDic)
        }) { (error) in
            failure(error)
        }
    }
    
    
    /// 通讯录请求
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - success: 成功
    ///   - failure: 失败
    class func getAddressBook(type:ENUM_QX_AddressBook ,success: @escaping(String?,Dictionary <String , AnyObject>?) -> (),failure: @escaping(NSError?) -> ()) {
        var param : [String : String] = Dictionary()
        param["type"] = "\(type.rawValue)"
        RequestSeverManager.YXB_Request_String(WithURLStr: ADDRESSBOOK, andParameters: param, success: { (responseStr, responseDic) in
            success(responseStr,responseDic)
        }) { (error) in
            failure(error)
        }
    }
    
    /// 通讯录请求
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - success: 成功
    ///   - failure: 失败
    
    
    /// 通讯录请求 按组织架构
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - level: 组织级别
    ///   - QueryScope: 查询范围
    ///   - org: 组织ID
    ///   - success: 成功
    ///   - failure: 失败
    class func getAddressBookGroupByOrg(type:ENUM_QX_AddressBook,level:String,QueryScope:ENUM_QX_AddressBook_Cope,org:String?=YXB_Singleton.sharedInstance.getUserInfoModel().orgId ,success: @escaping(String?,Dictionary <String , AnyObject>?) -> (),failure: @escaping(NSError?) -> ()) {
        var param : [String : String] = Dictionary()
        param["type"] = "\(type.rawValue)"
        param["scope"]="\(QueryScope.rawValue)"
        param["level"]=level
        
        RequestSeverManager.YXB_Request_String(WithURLStr: GET_USERGROUP, andParameters: param, org:org , success: { (responseStr, responseDic) in
            success(responseStr,responseDic)
        }) { (error) in
            failure(error)
        }
    }
    
    
    
    class func sequence(modelList:[QX_ContactsListInfoModel],orgList:[QX_ContactsOrgModel]?=Array()) -> ([String],[[QX_ContactsListInfoModel]],[QX_ContactsOrgModel]) {
        
        
        var indexList:[String]=Array()
        
        var list_C:[[QX_ContactsListInfoModel]]=Array()
        for itemModel in modelList {
            
            let PY_Str = String.transformToPinYin(text: itemModel.usersName!).capitalized
            let indexStr = (PY_Str as NSString).substring(to: 1)
            
            
            
            if list_C.count>0 {
                //存在 索引
                if indexList.contains(indexStr) {
                    
                    
                    //获取索引所在位置
                    let List_in=indexList.index(of: indexStr)
                    
                    //获取 索引对应的section List
                    var tepItemList = list_C[List_in!]
                    tepItemList.append(itemModel)
                    
                    tepItemList.sort(by: { (m1, m2) -> Bool in
                        m1.usersName!<=m2.usersName!
                    })
                    
                    list_C.remove(at: List_in!)
                    list_C.insert(tepItemList, at: List_in!)
                    
                    
                } else {
                    //不存在
                    indexList.append(indexStr)
                    indexList.sort(by: { (s1, s2) -> Bool in
                        s1<=s2
                    })
                    
                    let List_in=indexList.index(of: indexStr)
                    var section:[QX_ContactsListInfoModel] = Array()
                    section.append(itemModel)
                    list_C.insert(section, at: List_in!)
                    
                }
                
            }else{
                indexList.append(indexStr)
                var section:[QX_ContactsListInfoModel] = Array()
                section.append(itemModel)
                list_C.append(section)
            }
            
        }
        
        
        var list_O:[QX_ContactsOrgModel]=Array()
        if (orgList?.count)! > 0 {
            indexList.insert("*", at: 0)
            for itemModel in orgList! {
                list_O.append(itemModel)
                
            }
            
            if list_O.count>1 {
                //存在
                list_O.sort(by: { (item1, item2) -> Bool in
                    String.transformToPinYin(text: item1.name!).capitalized<=String.transformToPinYin(text: item2.name!).capitalized
                })
                
            }
        }
        
        
        return (indexList,list_C,list_O)
    }
}
