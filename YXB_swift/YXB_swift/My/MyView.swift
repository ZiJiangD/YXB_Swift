//
//  MyView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/10.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class MyView: UIView,UITableViewDelegate,UITableViewDataSource {

    let iconNameList:[String] = ["er","Sweep-1","bao_my","medal","config"]
    let titleList:[String] = ["名片二维码","扫一扫","我的考勤","我的荣誉","设置"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.myTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //TODO:delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section==0 && indexPath.row==0 {
            let cell: My_MessageCell = tableView.dequeueReusableCell(withIdentifier: "cell")as! My_MessageCell
            cell.selectionStyle = .none
            cell.setMessageCellUI(title: YXB_Singleton.sharedInstance.getUserInfoModel().realName!, subTitle: YXB_Singleton.sharedInstance.getUserInfoModel().orgName!, logoImageStr: YXB_Singleton.sharedInstance.getUserInfoModel().headImg)
            return cell
        } else{
            
            let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell2");
            cell.imageView?.image=UIImage(named: iconNameList[indexPath.section*3+indexPath.row-1]);
            cell.textLabel?.text=titleList[indexPath.section*3+indexPath.row-1]
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 && indexPath.row==0{
            return 70
        }else{
            return 44
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row==1 && indexPath.section==0 {
            let cardVC: My_BusinessCardVC = My_BusinessCardVC()
            
            Common.currentViewController()?.navigationController?.pushViewController(cardVC, animated: true)
        }else if indexPath.row == 2 && indexPath.section == 0 {
        

//            let scanVC:QQLBXScanViewController = QQLBXScanViewController()
//            scanVC.style=StyleDIY.qqStyle()
//            //镜头拉远拉近功能
//            scanVC.isVideoZoom = true
//            scanVC.qqlbxScan_Block = {(scanResultDic)->Void in
//                
//                delog(scanResultDic)
//                
//               
//                
//                
//            }
            let scanVC:ScanCradVC = ScanCradVC()
            Common.currentViewController()?.navigationController?.pushViewController(scanVC, animated: true)
        }
    }
    
    
    
    //lazy
    lazy var myTable : UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:spaceSeparatorHeight ,width:self.frame.size.width, height:self.frame.size.height-spaceSeparatorHeight), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        let nib : UINib = UINib(nibName: "My_MessageCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        return tepTable
    }()


    
}
