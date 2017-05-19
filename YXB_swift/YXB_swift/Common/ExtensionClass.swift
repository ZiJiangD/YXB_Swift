//
//  ExtensionClass.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/28.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import UIKit

//TODO:Extension UIColor
extension UIColor{
    class func color(withHexString colorStr: String ,alpha:CGFloat?) -> UIColor {
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        
        if strlen(cStr)<6 {
            return UIColor.clear
        }
        
        if cStr.hasPrefix("0x") {
            //            cStr=(cStr as NSString).substring(from: 2)
            //
            let tepStr = "0x"
            cStr = cStr.substring(from: tepStr.endIndex);
        }
        if cStr.hasPrefix("#"){
            let tempStr = "#"
            cStr = cStr.substring(from: tempStr.endIndex)
            
        }
        //截取之后判断位数是否足 6 位
        if strlen(cStr) != 6 {
            return UIColor.clear
        }
        
        var range = NSRange()
        range.length=2
        range.location=0
        
        //r
        let rStr : String = (cStr as NSString).substring(with: range)
        
        //g
        range.location=2
        let gStr : String = (cStr as NSString).substring(with: range)
        
        //b
        range.location=4
        let bStr : String = (cStr as NSString).substring(with: range)
        
        var r : CUnsignedInt = 0
        var g : CUnsignedInt = 0
        var b : CUnsignedInt = 0
        
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha!)
    }
    
    class func color(withHexString colorStr: String) -> UIColor {
        
        return UIColor.color(withHexString: colorStr, alpha: 1.00)
    }

}

extension UIImage{

    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }

}

//TODO:Extension String

extension String{
    
    static func showTost(_ messageStr: String?) -> Void {
        if messageStr == nil || messageStr?.characters.count == 0 {
            return
        }
        var showview: UIView?
        let window: UIWindow? = UIApplication.shared.keyWindow
        if showview == nil {
            showview = UIView()
            showview?.backgroundColor = UIColor.black
            showview?.frame = CGRect(x: CGFloat(1), y: CGFloat(1), width: CGFloat(1), height: CGFloat(1))
            showview?.alpha = 1.0
            showview?.layer.cornerRadius = 5.0
            showview?.layer.masksToBounds = true
            window?.addSubview(showview!)
            let label = UILabel()
            let tdic: [AnyHashable: Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: CGFloat(20))]
            
            let LabelSize = messageStr?.boundingRect(with: CGSize(width: CGFloat(290), height: CGFloat(9000)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: tdic as? [String : Any], context: nil).size
            label.frame = CGRect(x: CGFloat(10), y: CGFloat(5), width: CGFloat((LabelSize?.width)!), height: CGFloat((LabelSize?.height)!))
            label.text = messageStr
            label.numberOfLines = 0 //支持多行显示
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.backgroundColor = UIColor.clear
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(15))
            showview?.addSubview(label)
            showview?.frame = CGRect(x: CGFloat((SCREENWIDTH - (LabelSize?.width)! - 20) / 2), y: CGFloat(SCREENHEIGHT - 100), width: CGFloat((LabelSize?.width)! + 20), height: CGFloat((LabelSize?.height)! + 10))
            //3秒后消失
            UIView.animate(withDuration: 3, animations: { 
                showview?.alpha = 0.0
            })
            
            UIView.animate(withDuration: 3, animations: { 
                showview?.alpha = 0.0
            }, completion: { (finished : Bool) in
                showview = nil
                showview?.removeFromSuperview()
            })
        }
    }


    
    
    /// 字符串转字典
    ///
    /// - Parameter text: 转换的字符串
    /// - Returns: 装换后的字典
    static func covertStringToDictory(text :String) -> [String :AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String : AnyObject]
            } catch let error as NSError {
                delog("--ERROR--\(error)")
            }
        }
        return nil
    }
    
    static func callString(phoneNumStr phoneStr: String) -> Void {
        let Str : String = "telprompt://"+phoneStr
        let url : URL = URL(string: Str)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: Dictionary(), completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
        
    }
    static func calculationHeight(withText text: String?, andFontSize font : CGFloat, andWithWidth width : CGFloat) -> CGFloat {
        
        let calculationStr : NSString = text! as NSString
        let attr = [NSFontAttributeName:UIFont.systemFont(ofSize: font)]
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let stringSize : CGRect = calculationStr.boundingRect(with: size, options: .usesLineFragmentOrigin , attributes: attr, context: nil)
        return CGFloat(ceilf(Float(stringSize.height)))
        
    }
    static func calculationWidth(withText text: String?, andFontSize font : CGFloat, andWithHeight height : CGFloat) -> CGFloat {
        
        let calculationStr : NSString = text! as NSString
        let attr = [NSFontAttributeName:UIFont.systemFont(ofSize: font)]
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height )
        let stringSize : CGRect = calculationStr.boundingRect(with: size, options: .usesLineFragmentOrigin , attributes: attr, context: nil)
        return CGFloat(ceilf(Float(stringSize.width)))//stringSize.width
        
    }
    
    static func countOccurences(_of searchString: String, with itemStr: String) -> Int {
         let strCount: Int = itemStr.characters.count - itemStr.replacingOccurrences(of: searchString, with: "").characters.count
        return strCount / searchString.characters.count
        
    }
    
    static func transformToPinYin(text :String) -> String {
        let mutableStr = NSMutableString(string: text)
        //汉字转拼音
        CFStringTransform(mutableStr, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableStr, nil, kCFStringTransformStripDiacritics, false)
        let Str = String(mutableStr)
        
        //去掉空格
        
        return Str.replacingOccurrences(of: " ", with: "")
        
        
    }
}

//TODO:Extension Dictionary
extension Dictionary{
    
    /// 字典转字符串
    ///
    /// - Parameter dict: 字典
    /// - Returns: 字符串
    static func convertDictoryToString(dict: [String:AnyObject]) -> String {
        var result:String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = jsonString
            }
        } catch let error as NSError {
            delog("--ERROR--\(error)")
            result = ""
        }
        return result
    }
}



//TODO:Extension UIViewController
import MBProgressHUD.MBProgressHUD
let keyWindow : UIWindow = UIApplication.shared.keyWindow!
private var HUDKey = "HUDKey"
extension UIViewController{
    var hud : MBProgressHUD?{
        get{
            return objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD
        }
        set{
            objc_setAssociatedObject(self, &HUDKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func showHud(hint : String?, yOffset : CGFloat?) -> Void {
        let view = keyWindow
        
        for item in view.subviews {
            
            if type(of: item) == MBProgressHUD.self{
//                delog("=============")
//                let vc = Common().getCurrentVC(withView: item)
                let vc = Common.currentViewController()!
                
                vc.hideHud()
//                delog("VC: \(NSStringFromClass(type(of: vc)))")
            }
//            delog("deinit: \(NSStringFromClass(type(of: item)))")
        }
        
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        hud = HUD
    }
    
    func hideHud() -> Void {
        //如果解包成功则移除，否则不做任何事
        if hud != nil {
            //            tempHud.hide(animated: true)
            MBProgressHUD.hide(for: keyWindow, animated: true)
        }
    }
    
}








