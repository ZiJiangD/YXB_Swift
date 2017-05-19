//
//  Common.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import UIKit
import AdSupport




class Common: NSObject {
    /// 初始化App时调用 用于获取系统参数
    func getSyStemParameters() -> Void {
        
        
        //广告标示符（IDFA-identifierForIdentifier） 唯一标识
        let imei : String = ASIdentifierManager.shared().advertisingIdentifier.uuidString//手机唯一标识
        let appVersion : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String//当前app版本
        let phoneVersion : String = UIDevice.current.systemVersion//ios系统版本
        let phoneModel : String? = getDeviceVersion()//手机型号
        let sig = "000000000"//数字签名
        let inteVersion = INTE_VERSION//接口版本号
        
        var sysParam = SystemParameterModel()
        sysParam.system = "2"
        sysParam.imei = imei
        sysParam.currentVersion = appVersion
        sysParam.systemVersion = phoneVersion
        sysParam.model = phoneModel
        sysParam.sig = sig
        sysParam.inteVersion = inteVersion
        let singleton : YXB_Singleton = YXB_Singleton.sharedInstance
        singleton.setSysReqModel(sysReqModel: sysParam)
        
        
    }
    //获取手机版本
    private func getDeviceVersion () -> String? {
        let name = UnsafeMutablePointer<utsname>.allocate(capacity: 1)
        uname(name)
        let machine = withUnsafePointer(to: &name.pointee.machine, { (ptr) -> String? in
            
            let int8Ptr = unsafeBitCast(ptr, to: UnsafePointer<CChar>.self)
            return String(cString: int8Ptr)
        })
        name.deallocate(capacity: 1)
        if let deviceString = machine {
            switch deviceString {
            //iPhone
            case "iPhone1,1":
                return "iPhone 2G (A1203)"
            case "iPhone1,2":
                return "iPhone 3G (A1241/A1324)"
            case "iPhone2,1":
                return "iPhone 3GS (A1303/A1325)"
            case "iPhone3,1","iPhone3,3","iPhone3,2":
                return "iPhone 4 (A1332/A1349)"
            case "iPhone4,1":
                return "iPhone 4S (A1387/A1431)"
            case "iPhone5,1","iPhone5,2":
                return "iPhone 5 (A1428/A1429/A1442)"
            case "iPhone5,3","iPhone5,4":
                return "iPhone 5c (A1456/A1532/A1507/A1516/A1526/A1529)"
            case "iPhone6,1", "iPhone6,2":
                return "iPhone 5S (A1453/A1533/A1457/A1518/A1528/A1530)"
            case "iPhone7,1":
                return "iPhone 6 Plus (A1522/A1524)"
            case "iPhone7,2":
                return "iPhone 6 (A1549/A1586)"
            case "iPhone8,1":
                return "iPhone 6s (A1700)"
            case "iPhone8,2":
                return "iPhone 6s Plus (A1699)"
            case "iPhone9,1":
                return "iPhone 7 "
            case "iPhone9,2":
                return "iPhone 7 Plus "
                
                
                
            case "i386":
                return "iPhone Simulator"
            case "x86_64":
                return "iPhone Simulator"
            default:
                return deviceString
            }
        } else {
            return nil
        }
    }
    
    
    /// nsstring类型版本号转换为int类型版本号 @"2.0.0" -> 200
    ///
    /// - Parameter version: 字符串版本号
    /// - Returns: int类型版本号
    func exchangVersionStr_to_Int(StrVersion version: String) -> Int {
        if version.characters.count>0 {
            var resStr : String = String()
            var strList : [String] = version.components(separatedBy: ".")
            for i in 0...(strList.count-1) {
                if i == 0 {
                    resStr = strList[0]
                }else{
                    resStr += strList[i]
                }
            }
            return Int(resStr)!
        }
        return 0
    }
    
    
    /// 退出APP
    func exitApp() -> Void {
        let appDelegate = UIApplication.shared.delegate
        UIView.beginAnimations("EXIT_APP", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationTransition(UIViewAnimationTransition.none, for: ((appDelegate?.window)!)!, cache: false)
        UIView.setAnimationDidStop(#selector(animationFinshed(animationID:)))
        
    }
    @objc private func animationFinshed(animationID :String) -> Void {
        if animationID == "EXIT_APP"{
            exit(0)
        }
    }
    
    
    /*
    func checkUp() -> Void {
        
        
        //启动页
        let launchVc = WSJLaunchVC()
        UIApplication.shared.keyWindow?.rootViewController = launchVc
        
        
        let parameters : [String : String] = Dictionary()
        
        
        
        RequestSeverManager.WSJ_Request_String(WithURLStr: GET_UPDATE_INFO, andParameters: parameters, success: { (responseStr : String?, responseDic : Dictionary<String, AnyObject>?) in
            delog("---RESPONSE---\(String(describing: responseStr))")
            
            if responseDic?["code"] as! String == CODE_SUCCESS{
                var infoDic :[String :String] = responseDic?["data"]!["info"] as! [String :String]
                
                let appC = WSJ_Singleton.sharedInstance.getSysReqModel()
                
                let lastV_int=self.exchangVersionStr_to_Int(StrVersion: infoDic["lastVersion"]!)//最后版本
                let forceV_int=self.exchangVersionStr_to_Int(StrVersion: infoDic["forceVersion"]!)//最后版本
                let currentV_int=self.exchangVersionStr_to_Int(StrVersion: appC.currentVersion!)
                
                var message = String()
                let downLoadUrl :String = infoDic["download"]!
                if forceV_int > currentV_int{
                    message = infoDic["forceMessage"]!
                    
                    let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "狠心离开", style: UIAlertActionStyle.cancel, handler: { (action : UIAlertAction) in
                        self.exitApp()
                    })
                    let updateAction = UIAlertAction(title: "立即更新", style: UIAlertActionStyle.default, handler: { (action : UIAlertAction) in
                        
                        
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(NSURL(string: downLoadUrl)! as URL, options: [String : Any](), completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                            UIApplication.shared.openURL(NSURL(string: downLoadUrl)! as URL)
                        }
                        self.exitApp()
                    })
                    
                    alertVC.addAction(cancelAction)
                    alertVC.addAction(updateAction)
                    
                    let rootVC = UIApplication.shared.keyWindow?.rootViewController
                    
                    rootVC?.present(alertVC, animated: true, completion: nil)
                }else{
                    if currentV_int < lastV_int{//选择更新
                        message = infoDic["forceMessage"]!
                        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title: "以后再说", style: UIAlertActionStyle.cancel, handler: { (action : UIAlertAction) in
                            //MARK:选更新
                            self.loginOrAutoLogin()
                            
                        })
                        let updateAction = UIAlertAction(title: "立即更新", style: UIAlertActionStyle.default, handler: { (action : UIAlertAction) in
                            //MARK:立即更新
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(NSURL(string: downLoadUrl)! as URL, options: [String : Any](), completionHandler: nil)
                            } else {
                                // Fallback on earlier versions
                                UIApplication.shared.openURL(NSURL(string: downLoadUrl)! as URL)
                            }
                            
                        })
                        
                        alertVC.addAction(cancelAction)
                        alertVC.addAction(updateAction)
                        
                        let rootVC = UIApplication.shared.keyWindow?.rootViewController
                        
                        rootVC?.present(alertVC, animated: true, completion: nil)
                    }else{//不更新
                        //登录
                        self.loginOrAutoLogin()
                    }
                }
            }
        }) { (error : NSError?) in
            delog("---ERROR---\(String(describing: error))")
        }
*/

    
    
    
    
    
    
    //TODO:工具
    
    
    //MARK: 获取当前控制器
//    func getCurrentVC(withView view: UIView?) -> UIViewController {
//        /*
//        var result : UIViewController?
//        //        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
//        
//        //8.0 以上系统
//        
//        var topWindow : UIWindow = ((UIApplication.shared.delegate?.window)!)!
//        if topWindow.windowLevel != UIWindowLevelNormal {
//            let windowList : [UIWindow] = UIApplication.shared.windows
//            for tempWindow in windowList {
//                if tempWindow.windowLevel == UIWindowLevelNormal {
//                    topWindow = tempWindow
//                    break
//                }
//            }
//        }
//        var frontView : UIView
//        if view != nil {
//            frontView = view!
//        }else if(topWindow.subviews.count>0){
//            frontView = (topWindow.subviews[0] as UIView)
//        }else{
//            frontView=topWindow
//        }
//        
//        let nextResponder: Any? = frontView.next
//        if (nextResponder is UIViewController) {
//            result = nextResponder as! UIViewController?
//        }else {
//            result = topWindow.rootViewController
//        }
//        delog("---FUN---getCurrentVC=\(String(describing: result))")
//        return result!
// */
// 
//    }
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        delog("---FUN---getCurrentVC=\(String(describing: base))")
        return base
    }
    
    
}
