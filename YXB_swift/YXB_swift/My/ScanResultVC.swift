//
//  ScanResultVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/18.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class ScanResultVC: SecondBaseVC ,UITableViewDelegate,UITableViewDataSource{

    
    var headrList:[[String:String]]=Array()
    var bodyList:[[String:String]]=Array()
    
    
    
    var paramDic:[String:String]?{
        didSet{
            for keyItem in (paramDic?.keys)! {
                
                switch keyItem {
                case "移动电话","工作电话","邮箱","工作地址","公司","网址":
                    bodyList.append([keyItem:(paramDic?[keyItem])!])
                    break
                case "name","logoUrl","position":
                    headrList.append([keyItem:(paramDic?[keyItem])!])
                    break
                default:
                    delog("数据异常")
                }
                
//                self.resultTable.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        paramDic=Dictionary()
        self.view.addSubview(self.resultTable)
    }

    
    
    
    //TODO:delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }else{
            return bodyList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section==0 && indexPath.row==0 {
            let cell: My_MessageCell = tableView.dequeueReusableCell(withIdentifier: "cell")as! My_MessageCell
            cell.selectionStyle = .none
            cell.setScanCellUI(title: YXB_Singleton.sharedInstance.getUserInfoModel().realName!, subTitle: YXB_Singleton.sharedInstance.getUserInfoModel().orgName!, logoImageStr: YXB_Singleton.sharedInstance.getUserInfoModel().headImg)
            return cell
        } else{
            
            let cell: My_Info_Two_Cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo")as! My_Info_Two_Cell
            cell.selectionStyle = .none
            
            let Dic:[String:String]=bodyList[indexPath.row]
            for (key,value) in Dic {
                cell.setScanCellUI(title: key, subTitle: value)
            }
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
//        if cell.responds(to:#selector(setter: UIView.layoutMargins)) {
//            cell.layoutMargins = UIEdgeInsets.zero
//        }
//        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
//            cell.separatorInset = UIEdgeInsets.zero
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 && indexPath.row==0{
            return 90
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 80
        }else{
            return spaceSeparatorHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section==1 {
            let footView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 80))
            
            let addButton:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH-4*spaceSeparatorHeight, height: 44))
            addButton.center = footView.center
            addButton.backgroundColor = tabBarColor
            addButton.layer.cornerRadius = 4.0
            addButton.layer.masksToBounds = true
            addButton.setTitle("保存到手机", for: .normal)
            addButton.titleLabel?.textColor = UIColor.white
            footView.addSubview(addButton)
            return footView
        }else{
        
            return UIView()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
    
    
    
    
    
    //lazy
    lazy var resultTable : UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:64+spaceSeparatorHeight ,width:self.view.frame.size.width, height:self.view.frame.size.height-spaceSeparatorHeight-64), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        let nib : UINib = UINib(nibName: "My_MessageCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        let nib2 : UINib = UINib(nibName: "My_Info_Two_Cell", bundle: nil)
        tepTable.register(nib2, forCellReuseIdentifier: "cellTwo")
        return tepTable
    }()

}
