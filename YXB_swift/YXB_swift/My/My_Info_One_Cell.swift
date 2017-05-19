//
//  My_Info_One_Cell.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/15.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class My_Info_One_Cell: UITableViewCell,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var nextImageV: UIImageView!
    
    @IBOutlet weak var iconButtonWidth: NSLayoutConstraint!
    
    
    var info_One_CellEdithInfo_Block : ((UseInfoModel) -> Void)?
    var myModel:UseInfoModel?
    var imagePicker : UIImagePickerController?
    var  alertC: UIAlertController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconButton.isUserInteractionEnabled = false;
        nextImageV.isHidden = false
        
        iconButton.layer.cornerRadius=4.0
        iconButton.layer.masksToBounds=true
        self.imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        self.imagePicker?.allowsEditing = false
        
        alertC = UIAlertController(title: "图片选择", message: nil, preferredStyle: .alert)
        let noDiscountAction = UIAlertAction(title: "从相册选择", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.imagePicker?.sourceType = .photoLibrary
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                Common.currentViewController()?.present(self.imagePicker!, animated: true, completion: nil)
            }
        })
        let cashDiscountAction = UIAlertAction(title: "照相机", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.imagePicker?.sourceType = .camera
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                Common.currentViewController()?.present(self.imagePicker!, animated: true, completion: nil)
            }
        })
        let discountAction = UIAlertAction(title: "取消", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        })
        alertC?.addAction(noDiscountAction)
        alertC?.addAction(cashDiscountAction)
        alertC?.addAction(discountAction)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellOneUI(model:UseInfoModel,isEdith:Bool,indezPath:IndexPath) {
        
        myModel=model
        if isEdith {
            iconButton.isUserInteractionEnabled = true;
            nextImageV.isHidden = false
        }else{
            iconButton.isUserInteractionEnabled = false;
            nextImageV.isHidden = true
        }
        let url :URL? = URL(string: model.headImg)
        iconButton.sd_setBackgroundImage(with: url, for: .normal);
    }
    
    
    
    @IBAction func onClickButton(_ sender: UIButton) {
        delog("onClickButton")
        
        Common.currentViewController()?.present(alertC!, animated: true, completion: {() -> Void in
        })

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if picker.sourceType == UIImagePickerControllerSourceType.camera{
            let original_image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            UIImageWriteToSavedPhotosAlbum(original_image, self, #selector(funimage(_:didFinishSavingWithError:contextInfo:)), nil)
            
        }
        
        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        
        
        self.imagePicker?.dismiss(animated: true, completion: {
            
            RequestSeverManager.YXB_UPLOAD_Photo(uploadModule: ENUM_UPLOAD_PHOTO_MODULE.UPLOAD_PHOTO_MODULE.rawValue, imagelist: [image], success: { (responseStr, responseDic) in
                delog(responseDic)
                
                if responseDic?["code"] as! String == CODE_SUCCESS {
                    let list:[String] = responseDic?["data"] as! [String]
                    
                    
                    self.myModel?.headImg = PhotoAddress + list[0]
                    self.info_One_CellEdithInfo_Block!(self.myModel!)
                }
                
                
            }) { (error) in
                Common.currentViewController()?.hideHud()
                delog(error)
            }
        })
    }
    
    func funimage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
        // Was there an error?
        if error != nil {
            // Show error message...
        }
        else {
            // Show message image successfully saved
        }
    }
    
    
    

}
