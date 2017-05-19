//
//  AddressBookVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/19.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class AddressBookVC: SecondBaseVC {

    //address Book对象，用来获取电话簿句柄
    var addressBook: ABAddressBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //定义一个错误标记对象，判断是否成功
        var error:Unmanaged<CFError>?
        addressBook = ABAddressBookCreateWithOptions(nil, &error).takeUnretainedValue()
        
        //发送授权信息
        let sysAB_Status = ABAddressBookGetAuthorizationStatus()
        if sysAB_Status == ABAuthorizationStatus.notDetermined {
            delog("requesting access.....")
            var errorRef:Unmanaged<CFError>? = nil
            
            ABAddressBookRequestAccessWithCompletion(addressBook, { (success, error) in
                if success {
                    //获取便利所有联系人
                    self.readRecords()
                }else{
                    delog("error")
                }
            })
            
        }else if sysAB_Status == ABAuthorizationStatus.denied || sysAB_Status == ABAuthorizationStatus.restricted{
            delog("access denied")
        }else if sysAB_Status == ABAuthorizationStatus.authorized{
            delog("access granted")
            self.readRecords()
        }
        
    }

    func readRecords(){
        var sysContacts:Array = ABAddressBookCopyArrayOfAllPeople(addressBook).takeUnretainedValue() as Array
        
        for contact in sysContacts {
            //获取姓
            var lastName = ABRecordCopyValue(contact, kABPersonLastNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("姓：\(lastName)")
            
            //获取名
            var firstName = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("名：\(firstName)")
            
            //昵称
            var nikeName = ABRecordCopyValue(contact, kABPersonNicknameProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("昵称：\(nikeName)")
            
            //公司（组织）
            var organization = ABRecordCopyValue(contact, kABPersonOrganizationProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("公司（组织）：\(organization)")
            
            //职位
            var jobTitle = ABRecordCopyValue(contact, kABPersonJobTitleProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("职位：\(jobTitle)")
            
            //部门
            var department = ABRecordCopyValue(contact, kABPersonDepartmentProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("部门：\(department)")
            
            //备注
            var note = ABRecordCopyValue(contact, kABPersonNoteProperty)?
                .takeRetainedValue() as! String? ?? ""
            delog("备注：\(note)")
            
            //获取电话
            var phoneValues:ABMutableMultiValue? = ABRecordCopyValue(contact, kABPersonPhoneProperty).takeUnretainedValue()
            if phoneValues != nil{
                for i in 0 ..< ABMultiValueGetCount(phoneValues) {
                    //获得标签名
                    var phoneLab = ABMultiValueCopyLabelAtIndex(phoneValues, i).takeUnretainedValue() as CFString
                    // 转为本地标签名（能看得懂的标签名，比如work、home
                    var  localizedPhoneLabel = ABAddressBookCopyLocalizedLabel(phoneLab).takeUnretainedValue() as! String
                    
                    var value = ABMultiValueCopyValueAtIndex(phoneValues, i)
                    var phone = value?.takeRetainedValue() as! String
                    
                    delog("\(localizedPhoneLabel):\(phone)")

                }
            }
            
            
            //获取Email
            var emailValues:ABMutableMultiValue? =
                ABRecordCopyValue(contact, kABPersonEmailProperty).takeRetainedValue()
            if emailValues != nil {
                delog("Email：")
                for i in 0 ..< ABMultiValueGetCount(emailValues){
                    
                    // 获得标签名
                    var label = ABMultiValueCopyLabelAtIndex(emailValues, i).takeRetainedValue()
                        as CFString;
                    var localizedLabel = ABAddressBookCopyLocalizedLabel(label)
                        .takeRetainedValue() as String
                    
                    var value = ABMultiValueCopyValueAtIndex(emailValues, i)
                    var email = value?.takeRetainedValue() as! String
                    delog("  \(localizedLabel):\(email)")
                }
            }
        
            
            //获取地址
            var addressValues:ABMutableMultiValue? =
                ABRecordCopyValue(contact, kABPersonAddressProperty).takeRetainedValue()
            if addressValues != nil {
                delog("地址：")
                for i in 0 ..< ABMultiValueGetCount(addressValues){
                    
                    // 获得标签名
                    var label = ABMultiValueCopyLabelAtIndex(addressValues, i).takeRetainedValue()
                        as CFString;
                    var localizedLabel = ABAddressBookCopyLocalizedLabel(label)
                        .takeRetainedValue() as! String
                    
                    var value = ABMultiValueCopyValueAtIndex(addressValues, i)
                    var addrNSDict:NSMutableDictionary = value!.takeRetainedValue()
                        as! NSMutableDictionary
                    var country:String = addrNSDict.value(forKey: kABPersonAddressCountryKey as String)
                        as? String ?? ""
                    var state:String = addrNSDict.value(forKey: kABPersonAddressStateKey as String)
                        as? String ?? ""
                    var city:String = addrNSDict.value(forKey: kABPersonAddressCityKey as String)
                        as? String ?? ""
                    var street:String = addrNSDict.value(forKey: kABPersonAddressStreetKey as String)
                        as? String ?? ""
                    var contryCode:String = addrNSDict
                        .value(forKey: kABPersonAddressCountryCodeKey as String) as? String ?? ""
                    delog("  \(localizedLabel): Contry:\(country) State:\(state) ")
                    delog("City:\(city) Street:\(street) ContryCode:\(contryCode) ")
                }
            }
            
            //获取纪念日
            var dateValues:ABMutableMultiValue? =
                ABRecordCopyValue(contact, kABPersonDateProperty).takeRetainedValue()
            if dateValues != nil {
                delog("纪念日：")
                for i in 0 ..< ABMultiValueGetCount(dateValues){
                    
                    // 获得标签名
                    var label = ABMultiValueCopyLabelAtIndex(emailValues, i).takeRetainedValue()
                        as CFString;
                    var localizedLabel = ABAddressBookCopyLocalizedLabel(label)
                        .takeRetainedValue() as String
                    
                    var value = ABMultiValueCopyValueAtIndex(dateValues, i)
                    var date = (value?.takeRetainedValue() as? NSDate)?.description ?? ""
                    delog("  \(localizedLabel):\(date)")
                }
            }
            
            //获取即时通讯(IM)
            var imValues:ABMutableMultiValue? =
                ABRecordCopyValue(contact, kABPersonInstantMessageProperty).takeRetainedValue()
            if imValues != nil {
                delog("即时通讯(IM)：")
                for i in 0 ..< ABMultiValueGetCount(imValues){
                    
                    // 获得标签名
                    var label = ABMultiValueCopyLabelAtIndex(imValues, i).takeRetainedValue()
                        as CFString;
                    var localizedLabel = ABAddressBookCopyLocalizedLabel(label)
                        .takeRetainedValue() as! String
                    
                    var value = ABMultiValueCopyValueAtIndex(imValues, i)
                    var imNSDict:NSMutableDictionary = value!.takeRetainedValue()
                        as! NSMutableDictionary
                    var serves:String = imNSDict
                        .value(forKey: kABPersonInstantMessageServiceKey as String) as? String ?? ""
                    var userName:String = imNSDict
                        .value(forKey: kABPersonInstantMessageUsernameKey as String) as? String ?? ""
                    delog("  \(localizedLabel): Serves:\(serves) UserName:\(userName)")
                }
            }
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

}
