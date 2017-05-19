//
//  RequestSeverManager.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/9.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import Alamofire

public class RequestSeverManager: NSObject {
    
    
    public class func YXB_Request_String(WithURLStr urlStr: String, andParameters parameters: [String : Any]? ,org:String?=YXB_Singleton.sharedInstance.getUserInfoModel().orgId, success: @escaping(String?,Dictionary <String , AnyObject>?) -> (),failure: @escaping(NSError?) -> () ) -> Void {
        
        let noTokenAPIList : [String] = [LOGIN,GET_UPDATE_INFO,OBTAINCODE,PASSWORDRESET,QUICK_ENTER_ACCOUNTV1_3,REGISTER];
        
        if (urlStr != GET_UPDATE_INFO && urlStr != BIND_CLOUD_SUCCESS) {
            Common.currentViewController()!.showHud(hint: nil, yOffset: nil)
        }
        
        var tepPara : [String : Any] = parameters!
        
        var URL_STR = APIAddress + urlStr
        
        
        if (!(noTokenAPIList.contains(urlStr))){
            let useInfoModel : UseInfoModel? = YXB_Singleton.sharedInstance.getUserInfoModel()
            if useInfoModel?.accessToken == nil {
                return
            }else{
                URL_STR = URL_STR + "?access_token=" + (useInfoModel?.accessToken)!
            }
            
        }
        
        
        
        for (key,value) in YXB_Singleton.sharedInstance.getSysReqModel().toJSON()! {
            tepPara[key] = (value as! String)
        }
        
        if urlStr != EditAccountInfo {
            tepPara["access_token"]=YXB_Singleton.sharedInstance.getUserInfoModel().accessToken
            tepPara["enterpriseId"]=YXB_Singleton.sharedInstance.getUserInfoModel().enterpriseId
            tepPara["orgId"]=org
            tepPara["userId"]=YXB_Singleton.sharedInstance.getUserInfoModel().id
            tepPara["operatorName"]=YXB_Singleton.sharedInstance.getUserInfoModel().realName
        }
        

        
        delog("========================\n paramter= \(tepPara) \n URL=\(URL_STR) \n ========================")
        Alamofire.request(URL_STR, method: .post, parameters: tepPara, encoding: JSONEncoding.default, headers: nil)
            .responseString {  (responseStr : DataResponse<String>  ) in
            if (urlStr != GET_UPDATE_INFO && urlStr != BIND_CLOUD_SUCCESS) {
                 Common.currentViewController()!.hideHud()
            }
                
                switch responseStr.result {
                case .success(let str):
                    let dic : Dictionary <String , AnyObject> = String.covertStringToDictory(text: str)!
//                    delog("---------------------FUNC_NET_WORK \n url=\(URL_STR) \n--------------\n parameters=\(String(describing: tepPara.toJSONValue())) \n--------------\n response=\(str)\n--------------------");
                    
                    /*
                    if dic["code"] as! String == CODE_TOKEN_INVALID{
                        if urlStr == AUTO_LOGIN{
                            success(str ,dic )
                        } else{
                            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "NO_TOKEN_INVALID"), object: self)
                        }
                        
                    } else if dic["code"] as! String == CODE_DISABLE_ACCOUNT{
                        if urlStr == AUTO_LOGIN{
                            success(str ,dic )
                        } else {
                            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "ACCOUNT_DISABLE"), object: self)
                        }
                        WSJ_NSUserDefault.deleteLoginUserInformation()
                        WSJ_Singleton.sharedInstance.setUserInfoModel(userInfoModel: UseInfoModel())
                    }else{
                        success(str ,dic )
                    }
                    
                   */
                    
                    success(str ,dic )
                    break;
                case .failure(let error):
                    let er : NSError = error as NSError
                    delog("---------------------FUNC_NET_WORK \n url=\(URL_STR) \n parameters=\(String(describing: tepPara.toJSONValue()))\n response=\(responseStr)\n--------------------");
                    failure(er)
                    
                    
                    if er.code == -1004 || er.code == -1009 {
                        String.showTost("网络异常,请检查网络")
                    } else if (er.code == -1001){
                        String.showTost("请求超时，点击重试")
                    } else {
                        String.showTost("请求数据失败")
                    }
                    break;
                }
        }
        
 
    }


    

    public class func YXB_UPLOAD_Photo( uploadModule: String, imagelist:[UIImage], success: @escaping(String?,Dictionary <String , AnyObject>?) -> (),failure: @escaping(NSError?) -> () ) -> Void {
        
        
        if imagelist.count==0 {
            return
        }
        
        Common.currentViewController()?.showHud(hint: nil, yOffset: nil)
        let URL_STR = APIAddress + UPLOADPHOTO
        var imageDataList : [Data] = Array()
        for image in imagelist {
            imageDataList.append(UIImagePNGRepresentation(image)!)
        }
        var tepPara : [String : Any] = Dictionary()//
        
        tepPara["module"] = uploadModule as Any
        
        tepPara["inteVersion"] = YXB_Singleton.sharedInstance.getSysReqModel().inteVersion
        tepPara["enterpriseId"] = YXB_Singleton.sharedInstance.getUserInfoModel().enterpriseId
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传

                for (key,value) in tepPara {
                     multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                }
                
                for i in 0..<imageDataList.count {
                    multipartFormData.append(imageDataList[i], withName: "file\(i)", fileName: "file\(i).jpg", mimeType: "image/jpg")
                }
        },
            to: URL_STR,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString(completionHandler: { ( responsStr:DataResponse<String>) in
                         Common.currentViewController()?.hideHud()
                        delog("URL = \(URL_STR)")
                        delog(responsStr)
                        switch responsStr.result {
                        case .success(let str):
                            let dic : Dictionary <String , AnyObject> = String.covertStringToDictory(text: str)!
                            delog("---------------------FUNC_NET_WORK \n url=\(URL_STR) \n--------------\n parameters=\(String(describing: tepPara.toJSONValue())) \n--------------\n response=\(str)\n--------------------");
                            
                            if dic["code"] as! String == CODE_SUCCESS{
                            
                                 success(str ,dic )
                            }else{
                                 success(str ,dic )
                            }
                            
                            delog(dic["msg"] as! String)
                            
                            //                    success(str ,dic )
                            break;
                        case .failure(let error):
                            let er : NSError = error as NSError
                            delog("---------------------FUNC_NET_WORK \n url=\(URL_STR) \n parameters=\(String(describing: tepPara.toJSONValue()))\n response=\(responsStr)\n--------------------");
                            failure(er)
                            
                            
                            if er.code == -1004 || er.code == -1009 {
                                String.showTost("网络异常,请检查网络")
                            } else if (er.code == -1001){
                                String.showTost("请求超时，点击重试")
                            } else {
                                String.showTost("请求数据失败")
                            }
                            break;
                        }

                    })
                    
                    break
                case .failure(let encodingError):
                    let er : NSError = encodingError as NSError
                    delog("---------------------FUNC_NET_WORK \n url=\(URL_STR) \n parameters=\(String(describing: tepPara.toJSONValue()))\n NSError=\(er)\n--------------------");
                    failure(er)
                    
                    
                    if er.code == -1004 || er.code == -1009 {
                        String.showTost("网络异常,请检查网络")
                    } else if (er.code == -1001){
                        String.showTost("请求超时，点击重试")
                    } else {
                        String.showTost("请求数据失败")
                    }
                    break
                }

        })
    

    
        
        
    }

}
