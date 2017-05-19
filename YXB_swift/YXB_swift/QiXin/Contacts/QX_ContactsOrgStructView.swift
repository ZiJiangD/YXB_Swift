//
//  QX_ContactsOrgStructView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/9.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import MJRefresh.MJRefresh

class QX_ContactsOrgStructView: UIView,UITableViewDelegate, UITableViewDataSource {


    var dataModel:QX_ContactsModel?{
        didSet{
            let afterSeq=QX_Service.sequence(modelList: (dataModel?.data.users)!, orgList: dataModel?.data.orgs)
            
            self.indexsList=afterSeq.0
            self.dataList_C=afterSeq.1
            self.dataList_O=afterSeq.2
            self.contactsTable.reloadData()
        }
    }
    
    
    //索引
    var indexsList:[String]=Array()    //重新组织后的结果 联系人
    var dataList_C:[[QX_ContactsListInfoModel]]=Array()    //重新组织后的结果 组织
    var dataList_O:[QX_ContactsOrgModel]=Array()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        self.addSubview(self.departmentView)
        self.addSubview(self.contactsTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect{
        didSet{
            let newFrame = frame
            super.frame = newFrame
        }
    }
    
    //TODO:delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexsList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataList_O.count>0 {
            if section == 0 {
                return dataList_O.count
            }else
            {
                return dataList_C[section-1].count
            }
        }else{
            return dataList_C[section].count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QX_ContactsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QX_ContactsCell
        if dataList_O.count>0 {
            if indexPath.section==0 {
                cell.setContactsOrgCellUI(model: dataList_O[indexPath.row])
                
            }else{
                let itemList = dataList_C[indexPath.section-1]
                cell.setContactsCellUI(model: itemList[indexPath.row])
                }
        }else{
            let itemList = dataList_C[indexPath.section]
            cell.setContactsCellUI(model: itemList[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 && dataList_O.count>0 {
            return 0.01
        }else{
            return 21
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section==0 && dataList_O.count>0{
            return UIView()
        }
        
        let label = UILabel(frame: CGRect(x: CGFloat(10), y: CGFloat(0), width: CGFloat(tableView.frame.size.width - 20), height: CGFloat(21)))
        label.textColor = UIColor.color(withHexString: "88888d")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: CGFloat(15))
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor(red: CGFloat(245 / 255.0), green: CGFloat(245 / 255.0), blue: CGFloat(249 / 255.0), alpha: CGFloat(1))
        label.text=indexsList[section]
        let clearanceView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(tableView.frame.size.width), height: CGFloat(21)))
        clearanceView.backgroundColor = UIColor(red: CGFloat(245 / 255.0), green: CGFloat(245 / 255.0), blue: CGFloat(249 / 255.0), alpha: CGFloat(1))
        clearanceView.addSubview(label)
        return clearanceView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if  dataList_O.count>0 {
            if indexPath.section==0  {
                let model = dataList_O[indexPath.row]
                let vc:QX_ContactsOrgStructVC = QX_ContactsOrgStructVC()
                vc.level=model.level!
                vc.scope = .QX_Org
                vc.org=model.id
                vc.orgName = model.name
                Common.currentViewController()!.navigationController?.pushViewController(vc, animated: true)
            }else{
                let tepList = dataList_C[indexPath.section-1]
                let model = tepList[indexPath.row]
                
                let infoVc:QX_ContactsInfoVC=QX_ContactsInfoVC()
                infoVc.infoModel = model
                
                Common.currentViewController()!.navigationController?.pushViewController(infoVc, animated: true)
            }
        }else{
            let tepList = dataList_C[indexPath.section
            ]
            let model = tepList[indexPath.row]
            
            let infoVc:QX_ContactsInfoVC=QX_ContactsInfoVC()
            infoVc.infoModel = model
            
            Common.currentViewController()!.navigationController?.pushViewController(infoVc, animated: true)
        }
        
        
        
    }
    //返回每个索引的内容
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexsList[section]
    }
    //返回索引数组
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexsList
    }
    //响应点击索引时的委托方法
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return  index
    }

    
    
    
    
    
    
    //lazy
    lazy var contactsTable: UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:self.departmentView.frame.maxY,width:self.frame.size.width, height:self.frame.size.height-self.departmentView.frame.size.height), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        tepTable.backgroundColor = UIColor.lightGray
        tepTable.sectionIndexColor=tabBarColor//设置默认时索引值颜色
        tepTable.sectionIndexTrackingBackgroundColor=UIColor.clear//设置选中时，索引背景颜色
        tepTable.sectionIndexBackgroundColor = UIColor.clear//设置默认时，索引的背景颜色

        let nib : UINib = UINib(nibName: "QX_ContactsCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        return tepTable
    }()
    
    lazy var departmentView: UIView = {
        var tepView: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: 44.0))
        var orgView : ContactsDepartmentChooseView = ContactsDepartmentChooseView(frame: CGRect(x: 0.0, y: 0.0, width: tepView.frame.size.width, height:tepView.frame.size.height-0.5))
        
        var vcNameList:[String]=Array()
        var VcList:[UIViewController] = (Common.currentViewController()?.navigationController?.viewControllers)!
        
        var vc_orgList: [UIViewController] = Array()
        var Vc_OthList: [UIViewController] = Array()
        for item in VcList{
            if item is QX_ContactsOrgStructVC {
                vcNameList.append(item.navigationItem.title!)
                vc_orgList.append(item)
            }else{
                Vc_OthList.append(item)
            }
            
        }
        vcNameList[0]="全公司"
        orgView.dataSource=vcNameList
        
        orgView.selectOrgTitle_Block={(num)->Void in

            for _ in (Vc_OthList.count+num+1) ..< ((Common.currentViewController()?.navigationController?.viewControllers.count)!-1){
                Common.currentViewController()?.navigationController?.viewControllers.removeLast()
            }
            Common.currentViewController()?.navigationController?.popViewController(animated: true)
            
            
            
            
            
//            var List:[UIViewController] = Vc_OthList+vc_orgList[0...num+1]
//            Common.currentViewController()?.navigationController?.viewControllers=List
//            Common.currentViewController()?.navigationController?.popViewController(animated: true)
        }
        tepView.addSubview(orgView)
        var bottomLine : UIImageView = UIImageView(frame: CGRect(x: 0, y: tepView.frame.size.height-0.5, width: tepView.frame.size.width, height: 0.5))
        bottomLine.image = UIImage(named: "line")
        tepView.addSubview(bottomLine)
        tepView.backgroundColor = spaceSeparatorColor
        return tepView
    }()

}
