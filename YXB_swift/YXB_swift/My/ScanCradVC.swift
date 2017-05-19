//
//  ScanCradVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/18.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

import LBXScan
import LBXScan.LBXScanViewStyle
import LBXScan.LBXScanNative

class ScanCradVC: SecondBaseVC {
    
    
    var isOpenInterestRect:Bool?

    var scanObj:LBXScanNative?
    var videoView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        isOpenInterestRect=false
        
        self.view.addSubview(self.topTitle)
        self.view.addSubview(self.qRScanView)
        
        
        videoView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        videoView?.backgroundColor = UIColor.clear
        self.view.insertSubview(videoView!, at: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.perform(#selector(startScan), with: nil, afterDelay: 0.2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        scanObj?.stopScan()
        qRScanView.stopScanAnimation()
        
    }
    
    
    
    
    func startScan()  {
        
        if scanObj == nil {
            var cropRect:CGRect = CGRect()
            if self.isOpenInterestRect! {
                cropRect = LBXScanView.getScanRect(withPreView: self.view, style: self.style)
            }
            
            let strCode:String = AVMetadataObjectTypeQRCode
            scanObj = LBXScanNative(preView: self.videoView , objectType: [strCode], cropRect: cropRect, success: { (resultList) in
                
                
                self.scanResultWithArray(array: resultList!)
            })
        }
        scanObj?.startScan()
        qRScanView.stopDeviceReadying()
        qRScanView.startScanAnimation()
        
        self.view.backgroundColor=UIColor.clear
        
        
    }
    
    func scanResultWithArray(array: [LBXScanResult]) -> Void {
        if ( array.count < 1){
            delog("识别失败")
        }
        
        let scanResult:LBXScanResult = array[0]
        var strResult:String = scanResult.strScanned
        
        if strResult.characters.count == 0 {
            delog("识别失败")
        }
        
        showNextVCWithScanResult(scanResult: scanResult)
    }
    
    func showNextVCWithScanResult(scanResult:LBXScanResult) {
        
//        delog(scanResult.strScanned)
        
        let vcardString:String=scanResult.strScanned
        let lines:[String] = vcardString.components(separatedBy: "\n")
        
        var vcaedDic:[String:String]=Dictionary()
        
        for lineItem in lines {
            if lineItem.hasPrefix("BEGIN")||lineItem.hasPrefix("END"){
                
            }else if lineItem.hasPrefix("FN:"){//姓名
                
                var upperComponents = lineItem.components(separatedBy: ":")
                vcaedDic["name"] = upperComponents[1]
                
            }else if lineItem.hasPrefix("PHOTO;JPG:"){//头像1
                
                var upperComponents = lineItem.components(separatedBy: ":")
                var logo:String=""
                if upperComponents.count>3{
                    logo=upperComponents[1]+":"+upperComponents[2]
                    vcaedDic["logoUrl"]=logo
                }
                
            }else if lineItem.hasPrefix("TITLE:"){//职位
                
                var upperComponents = lineItem.components(separatedBy: ":")
                vcaedDic["position"] = upperComponents[1]
                
            }else if lineItem.hasPrefix("TEL;CELL") || lineItem.hasPrefix("TEL;HOME") || lineItem.hasPrefix("TEL;MOBILE") || lineItem.hasPrefix("TEL;联系方式"){//个人电话
                
                var upperComponents = lineItem.components(separatedBy: ":")
                for i in 1..<upperComponents.count {
                    vcaedDic["移动电话"]=upperComponents[i]
                }
                
            }else if lineItem.hasPrefix("TEL;WORK"){//工作电话
                
                var upperComponents = lineItem.components(separatedBy: ":")
                for i in 1..<upperComponents.count {
                    vcaedDic["工作电话"]=upperComponents[i]
                }
                
            }else if lineItem.hasPrefix("EMAIL"){//邮箱
                
                var upperComponents = lineItem.components(separatedBy: ":")
                vcaedDic["邮箱"] = upperComponents[1]
                
            }else if lineItem.hasPrefix("ADR;"){//工作地址
                
                var upperComponents = lineItem.components(separatedBy: ":")
                vcaedDic["工作地址"] = upperComponents[1]
                
            }else if lineItem.hasPrefix("ORG:"){//公司名称
                
                var upperComponents = lineItem.components(separatedBy: ":")
                vcaedDic["公司"] = upperComponents[1]
                
            }else if lineItem.hasPrefix("URL:"){//url
                var upperComponents = lineItem.components(separatedBy: ":")
                var url:String = ""
                
                if upperComponents[0] == "http"{
                    url = upperComponents[1]+":"+upperComponents[2]
                }else{
                    url = upperComponents[1]
                }
                
                
                vcaedDic["网址"] = url
            }
            
        }
        
//        delog(vcaedDic)
        
        let scanVC:ScanResultVC=ScanResultVC()
        scanVC.paramDic=vcaedDic
        self.navigationController?.pushViewController(scanVC, animated: true)
        
    }
    
    
    
    lazy var qRScanView: LBXScanView = {
        var rect:CGRect=self.view.frame
        rect.origin=CGPoint(x: 0, y: 0)
        var tepView : LBXScanView = LBXScanView(frame: rect, style: self.style)
        tepView.startDeviceReadying(withText: "相机启动中")
        return tepView
    }()
    
    lazy var topTitle: UILabel = {
        var tepLab: UILabel=UILabel()
        tepLab.bounds=CGRect(x: 0, y: 0, width: 145, height: 60)
        tepLab.center=CGPoint(x: SCREENWIDTH/2.0, y: 50+64)
        tepLab.font = kFONT15
        if SCREENHEIGHT<=568 {
            tepLab.center = CGPoint(x: SCREENWIDTH/2.0, y: 38+64)
            tepLab.font = kFONT14
        }
        tepLab.textAlignment = .center
        tepLab.numberOfLines=0
        tepLab.text = "将取景框对准二维码即可自动扫描"
        tepLab.textColor = UIColor.white
        return tepLab
    }()
    
    lazy var style: LBXScanViewStyle = {
        //设置扫码区域参数设置
        var tepStyle:LBXScanViewStyle = LBXScanViewStyle()
        //矩形区域中心上移，默认中心点为屏幕中心点
        tepStyle.centerUpOffset = 44
        //扫码框周围4个角的类型,设置为外挂式
        tepStyle.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.outer;
        
        //扫码框周围4个角绘制的线条宽度
        tepStyle.photoframeLineW = 6;
        
        //扫码框周围4个角的宽度
        tepStyle.photoframeAngleW = 24;
        
        //扫码框周围4个角的高度
        tepStyle.photoframeAngleH = 24;
        
        //扫码框内 动画类型 --线条上下移动
        tepStyle.anmiationStyle = LBXScanViewAnimationStyle.lineMove;
        
        //线条上下移动图片
        tepStyle.animationImage = UIImage(named: "qrcode_scan_light_green")//[UIImage imageNamed("qrcode_scan_light_green"];
        return tepStyle

    }()
    
    lazy var zoomView: LBXScanVideoZoomView = {
        
        var z_frame = self.view.frame
        var XRetangleLeft:CGFloat = self.style.xScanRetangleOffset
        var sizeRetangle = CGSize(width: z_frame.size.width - XRetangleLeft*2, height: z_frame.size.width - XRetangleLeft*2)
        
        if self.style.whRatio != 1 {
            var w:CGFloat = sizeRetangle.width
            var h:CGFloat = w / self.style.whRatio
            
            var hInt:Int = Int(h)
            h=CGFloat(hInt)
            
            sizeRetangle = CGSize(width: w, height:h)
        }
//        var videoMaxScale:CGFloat = self.
        var tepView: LBXScanVideoZoomView=LBXScanVideoZoomView()
        return tepView
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

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
