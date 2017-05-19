//
//  QX_ContactsView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import MJRefresh.MJRefresh

class QX_ContactsView: UIView, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating {

    
    var isSearch : Bool? {
        didSet{
            UIView.animate(withDuration: 0.3, animations: {
                self.departmentView.frame = CGRect(x: 0.0, y: (self.isSearch! ? 0.0 : 44.0), width: self.frame.size.width, height: 44.0)
                
                self.contactsTable.frame = CGRect(x:0.0, y:self.departmentView.frame.maxY,width:self.frame.size.width, height:self.frame.size.height-self.departmentView.frame.size.height)
            }) { (finished) in
                
            }
            
            delog(self.mySearchBar.searchBar.frame)
        }
    }
    
    
    var indexsList:[String]=Array()
    //重新组织后的结果
    var dataList:[[QX_ContactsListInfoModel]]=Array()
    var dataModel:QX_ContactsModel = QX_ContactsModel()
    
    
    //搜索结果页面
    var resultVC:QX_ContactsSearchResultVC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = spaceSeparatorColor
        self.addSubview(self.mySearchBar.searchBar)
        self.addSubview(self.departmentView)
        self.addSubview(self.contactsTable)
        isSearch=false
        self.loadNewData()
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
        
        return dataList[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QX_ContactsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QX_ContactsCell
        let itemList = dataList[indexPath.section]
        
        cell.setContactsCellUI(model: itemList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        
        let tepList = dataList[indexPath.section]
        let model = tepList[indexPath.row]
        
        let infoVc:QX_ContactsInfoVC=QX_ContactsInfoVC()
        infoVc.infoModel = model
        
        Common.currentViewController()!.navigationController?.pushViewController(infoVc, animated: true)
    
        
        
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
    
    
    
    //searchBarDelegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        self.mySearchBar.searchBar.setShowsCancelButton(true, animated: true)
        self.isSearch=true
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == self.mySearchBar {
            //nothing
        }else{
            //UISearchController里面的searchBar
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
         UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.searchBar.setShowsCancelButton(false, animated: true)
        UIApplication.shared.keyWindow?.endEditing(true)
        self.mySearchBar.searchBar.text=""
        self.isSearch=false
        self.resultVC?.dataList = Array()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //搜索
        filterBySubstring(subStr: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //搜索
        filterBySubstring(subStr: searchBar.text!)
        // 放弃作为第一个响应者，关闭键盘
        searchBar.resignFirstResponder()
    }
    
    
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    //搜索
    func filterBySubstring(subStr:String) {
        let lowerStr = subStr.lowercased()
        
        var searchList:[QX_ContactsListInfoModel] = Array()
        
        if (lowerStr != "" && dataModel.data.usersList.count > 0) {
            for item in (dataModel.data.usersList) {
                let name_r = String.transformToPinYin(text: item.usersName!).contains(lowerStr)
                let mobile_r = String.transformToPinYin(text: item.mobile!).contains(lowerStr)
                let orgName_r = String.transformToPinYin(text: item.orgName!).contains(lowerStr)
                
                if name_r || mobile_r || orgName_r {
                    searchList.append(item)
                }
            }
            self.resultVC?.dataList = searchList
        }
        
        
    }
    
    
    
    
    func loadNewData() {
        QX_Service.getAddressBook(type: .QX_Communication, success: { (responSetr, responseDic) in
            delog(responseDic)
            self.contactsTable.mj_header.endRefreshing()
            let dataModel: QX_ContactsModel = QX_ContactsModel.deserialize(from: responSetr)!
            
            let afterSeq=QX_Service.sequence(modelList: dataModel.data.usersList)
            self.dataList=afterSeq.1
            self.indexsList=afterSeq.0
            self.dataModel=dataModel
            
            self.contactsTable.reloadData()
            
        }) { (error) in
            delog(error)
            self.contactsTable.mj_header.endRefreshing()
        }
    }
    
    func onClickOrgButton(_ button: UIButton) {
        let orgStructVC : QX_ContactsOrgStructVC = QX_ContactsOrgStructVC()
        Common.currentViewController()?.navigationController?.pushViewController(orgStructVC, animated: true)
        
    }
    
    
    
    
    
    //lazy
    lazy var contactsTable: UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:self.departmentView.frame.maxY,width:self.frame.size.width, height:self.frame.size.height-self.departmentView.frame.size.height-44.0), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        tepTable.backgroundColor = UIColor.lightGray
        tepTable.sectionIndexColor=tabBarColor//设置默认时索引值颜色
        tepTable.sectionIndexTrackingBackgroundColor=UIColor.clear//设置选中时，索引背景颜色
        tepTable.sectionIndexBackgroundColor = UIColor.clear//设置默认时，索引的背景颜色
        
        var header : MJRefreshNormalHeader = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
        tepTable.mj_header = header
        tepTable.mj_header.isAutomaticallyChangeAlpha = true
        
        let nib : UINib = UINib(nibName: "QX_ContactsCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        return tepTable
    }()
    
    lazy var mySearchBar: UISearchController = {
        self.resultVC = QX_ContactsSearchResultVC()
        let searchVC : UISearchController = UISearchController(searchResultsController: self.resultVC)
        searchVC.searchBar.frame = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 44.0)
        searchVC.searchBar.sizeToFit()
        
        searchVC.searchBar.backgroundColor = UIColor.lightGray
        searchVC.searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = "搜索";
        
        return searchVC
    }()

    lazy var departmentView: UIView = {
        var tepView: UIView = UIView(frame: CGRect(x: 0.0, y: self.mySearchBar.searchBar.frame.maxY, width: self.frame.size.width, height: 44.0))
        var btn: UIButton = UIButton(frame: CGRect(x: spaceSeparatorHeight, y: 0, width: tepView.frame.size.width/2.0, height: tepView.frame.size.height-0.5))
        btn.addTarget(self, action: #selector(onClickOrgButton(_:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "qiXin_struct"), for: UIControlState.normal)
        btn.setTitle("按组织架构", for: UIControlState.normal)
        btn.setTitleColor(tabBarColor, for: UIControlState.normal)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        tepView.addSubview(btn)
        
        var bottomLine : UIImageView = UIImageView(frame: CGRect(x: 0, y: tepView.frame.size.height-0.5, width: tepView.frame.size.width, height: 0.5))
        bottomLine.image = UIImage(named: "line")
        tepView.addSubview(bottomLine)
        tepView.backgroundColor = spaceSeparatorColor
        return tepView
    }()
}
