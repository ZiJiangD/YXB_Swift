//
//  EdithAndDetailMyInfoView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/15.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class EdithAndDetailMyInfoView: UIView ,UITableViewDelegate,UITableViewDataSource{

    
    var infoEdithInfo_Block : ((UseInfoModel) -> Void)?

    var model:UseInfoModel?{
        didSet{
            self.infoTable.reloadData()
        }
    }
    var isEdith:Bool?{
        didSet{
            self.infoTable.reloadData()
        }
    }
    
    let titleList:[String] = ["头像","姓名","公司","部门","职位","手机","邮箱","公司主页"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        model = UseInfoModel()
        isEdith=false
        
        self.addSubview(self.infoTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //TODO:delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 3
        }else if section == 1 {
            return 4
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section==0 && indexPath.row==0 {
            let cell: My_Info_One_Cell = tableView.dequeueReusableCell(withIdentifier: "oneCell") as! My_Info_One_Cell
            cell.selectionStyle = .none
            cell.setCellOneUI(model: model!, isEdith: self.isEdith!, indezPath: indexPath)
            cell.info_One_CellEdithInfo_Block = {(blockInfoModel:UseInfoModel)->Void in
                
                self.model = blockInfoModel
                
                self.infoEdithInfo_Block!(self.model!)
            }
            
            return cell
        } else{
            
            let cell2: My_Info_Two_Cell = tableView.dequeueReusableCell(withIdentifier: "twoCell") as! My_Info_Two_Cell
            cell2.selectionStyle = .none
            cell2.setCellTwoUI(titleList: titleList, model: model!, isEdith: self.isEdith!, indexPath: indexPath)
            cell2.info_Two_CellEdithInfo_Block = {(blockInfoModel:UseInfoModel)->Void in
                
                self.model = blockInfoModel
                
                self.infoEdithInfo_Block!(self.model!)
            }
            return cell2
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

    }

    lazy var infoTable: UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:spaceSeparatorHeight ,width:self.frame.size.width, height:self.frame.size.height-spaceSeparatorHeight), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        let nib : UINib = UINib(nibName: "My_Info_One_Cell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "oneCell")
        let nib2 : UINib = UINib(nibName: "My_Info_Two_Cell", bundle: nil)
        tepTable.register(nib2, forCellReuseIdentifier: "twoCell")
        return tepTable
    }()
}
