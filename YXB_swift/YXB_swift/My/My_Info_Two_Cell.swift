//
//  My_Info_Two_Cell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/15.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class My_Info_Two_Cell: UITableViewCell,UITextFieldDelegate {

    
    var info_Two_CellEdithInfo_Block : ((UseInfoModel) -> Void)?

    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var textF: UITextField!
    
    var myIndexPath:IndexPath?
    var myModel:UseInfoModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textF.delegate=self

        textF.isUserInteractionEnabled = false
        textF.textColor = UIColor.black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCellTwoUI(titleList:[String],model:UseInfoModel,isEdith:Bool,indexPath:IndexPath){
        
        myIndexPath=indexPath
        myModel=model
        var titleStr=""
        var contentStr = ""
        
        if indexPath.section==0 {
            titleStr=titleList[indexPath.row]
            switch indexPath.row {
            case 1:
                contentStr=(model.realName)!
                if isEdith {
                    textF.isUserInteractionEnabled = true
                    textF.textColor = UIColor.lightGray
                }else{
                    textF.isUserInteractionEnabled = false
                    textF.textColor = UIColor.black
                }
                break
            case 2:
                contentStr=(model.enterpriseName)!
                break
            default:
                delog("default")
                break
            }
            
        }else if indexPath.section==1 {
            titleStr=titleList[indexPath.row+indexPath.section*3]
            switch indexPath.row {
            case 0:
                contentStr=(model.orgName)!
                break
            case 1:
                contentStr=(model.positionName)!
                break
            case 2:
                contentStr=(model.mobile)!
                if isEdith {
                    textF.isUserInteractionEnabled = true
                    textF.textColor = UIColor.lightGray
                }else{
                    textF.isUserInteractionEnabled = false
                    textF.textColor = UIColor.black
                }
                break
            case 3:
                contentStr=(model.email)!
                if isEdith {
                    textF.isUserInteractionEnabled = true
                    textF.textColor = UIColor.lightGray
                }else{
                    textF.isUserInteractionEnabled = false
                    textF.textColor = UIColor.black
                }
                break
            default:
                delog("default")
                break
            }
        }else{
            titleStr=titleList[indexPath.row+indexPath.section*3+1]
            contentStr=(model.url)!
        }
        titleLab.text=titleStr;
        textF.text = contentStr
        
        
    }
    
    
    func setScanCellUI(title:String,subTitle:String){
        titleLab.text = title
        if title=="移动电话" || title=="工作电话" || title=="网址"{
        
            self.textF.textColor = tabBarColor
        }
        textF.text=subTitle
    }
       
    //    func textFieldDidChanged(_ textField: UITextField) {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        if (textField.text?.hasSuffix("."))! {
            let tepStr = (textField.text! as NSString).substring(to: (textField.text?.characters.count)! - 1)
            textField.text = tepStr
        }
        
        
        if myIndexPath?.section==0 {
            switch (myIndexPath?.row)! {
            case 1:
                myModel?.realName = textField.text
                break
            case 2:
                myModel?.enterpriseName = textField.text
                break
            default:
                delog("default")
                break
            }
            
        }else if myIndexPath?.section==1 {
            switch (myIndexPath?.row)! {
            case 0:
                myModel?.orgName = textField.text
                break
            case 1:
                myModel?.positionName=textField.text
                break
            case 2:
                myModel?.mobile=textField.text
                break
            case 3:
                myModel?.email=textField.text
                break
            default:
                delog("default")
                break
            }
        }else{
            myModel?.url=textField.text
        }
        delog(myModel)
        
        info_Two_CellEdithInfo_Block!(myModel!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == " " {
            return false
        }
        
        if textField.text == "" || textField.text == "0" {
            return true
        }
        
        
        
        return true
    }
}
