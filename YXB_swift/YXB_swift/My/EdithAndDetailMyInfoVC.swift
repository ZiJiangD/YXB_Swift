//
//  EdithAndDetailMyInfoVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/15.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class EdithAndDetailMyInfoVC: SecondBaseVC {

    var infoView:EdithAndDetailMyInfoView?
    var edithBarButtonItem:UIBarButtonItem?
    var model:UseInfoModel=YXB_Singleton.sharedInstance.getUserInfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title="我"
        
        
        edithBarButtonItem = UIBarButtonItem(title: "编辑", style: .done, target: self, action: #selector(onClickEdithButton))
        edithBarButtonItem?.tintColor = UIColor.white
    
        
        
        self.navigationItem.rightBarButtonItem = edithBarButtonItem
        
        
        infoView = EdithAndDetailMyInfoView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: SCREENHEIGHT-64.0))
        infoView?.model=YXB_Singleton.sharedInstance.getUserInfoModel()
        infoView?.infoEdithInfo_Block = {(edithModel) ->Void in
            self.model=edithModel
        }
        self.view.addSubview(infoView!);
        
        
    }
    
    
    func onClickEdithButton() {
        
        if (infoView?.isEdith)!{
            edithBarButtonItem?.title = "编辑"
            if model.toJSONString() == YXB_Singleton.sharedInstance.getUserInfoModel().toJSONString() {
                
            }else{
                edithAccountInfoRequest()
            }
        }else{
            edithBarButtonItem?.title = "保存"
        }
        
        infoView?.isEdith = !(infoView?.isEdith)!
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func edithAccountInfoRequest(){
        
          var para : [String:Any] = Dictionary()
        para["id"] = YXB_Singleton.sharedInstance.getUserInfoModel().id
        para["realName"] = model.realName
        para["headImg"] = (YXB_Singleton.sharedInstance.getUserInfoModel().headImg == model.headImg ? [] : [model.headImg.replacingOccurrences(of: PhotoAddress, with: "")])
        para["positionId"] = model.positionId
        para["email"] = model.email
        RequestSeverManager.YXB_Request_String(WithURLStr: EditAccountInfo, andParameters: para, success: { (responseStr, responseDic) in
            
            delog(responseStr)
            
            if responseDic?["code"] as! String == CODE_SUCCESS{

                YXB_Singleton.sharedInstance.setUserInfoModel(userInfoModel: self.model);
            }
            
            
            
            
        }) { (error) in
            
        }
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
