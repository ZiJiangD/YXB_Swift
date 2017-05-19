//
//  QX_MessageView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit
import MJRefresh.MJRefresh

class QX_MessageView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var unReadCount_Block: ((Int) -> ())?
    var chatList:[Any]?
    
    
    let messageIconList:[String] = ["bell","Volume","clock","user-group1"]
    let messageTitleList:[String] = ["公告","通知","工作提醒","共享消息"]
    let messageSubTitleList:[String] = ["查看公司公告","查看设置提醒、系统提醒","查看审批提醒，打卡提醒、拜访提醒","查看客户共享提醒，线索共享提醒"]
    var messageCountList:[String] = ["0","0","0","0"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.messageTable)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4 + (chatList?.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row<4
        {
            let cell: QX_MessageCell = tableView.dequeueReusableCell(withIdentifier: "cell")as! QX_MessageCell
            cell.setMessageCellUI(title: messageTitleList[indexPath.row], subTitle: messageSubTitleList[indexPath.row], countNumStr: messageCountList[indexPath.row], logoImageStr: messageIconList[indexPath.row])
            return cell
        }else{
            
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    func loadNewData() {
        QX_Service.getunReadCount(success: { (responseStr, responseDic) in
            self.messageTable.mj_header.endRefreshing()
            delog(responseDic)
            if (responseDic?["code"] as! String) == CODE_SUCCESS {
                let dic:[String:String] = responseDic?["data"] as! [String : String]
                self.messageCountList.removeAll()
                self.messageCountList.append(dic["anncCount"] ?? "0")
                self.messageCountList.append(dic["noticeCount"] ?? "0")
                self.messageCountList.append(dic["sharedNoticeCount"] ?? "0")
                self.messageCountList.append(dic["workWarnCount"] ?? "0")
                self.messageTable.reloadData()
                
                var totalCount : Int = 0
                for countStr in self.messageCountList{
                    totalCount += Int(countStr)!
                }
                
                self.unReadCount_Block!(totalCount)
                
            }else{
                
            }
            
        }) { (error) in
            self.messageTable.mj_header.endRefreshing()
            delog(error)
        }
    }
    
    
    //lazy
    
    lazy var messageTable: UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:0.0 ,width:self.frame.size.width, height:self.frame.size.height), style: UITableViewStyle.plain)
        tepTable.delegate = self
        tepTable.dataSource = self
        tepTable.backgroundColor = UIColor.lightGray
        
        var header : MJRefreshNormalHeader = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
        tepTable.mj_header = header
        tepTable.mj_header.isAutomaticallyChangeAlpha = true
        
        let nib : UINib = UINib(nibName: "QX_MessageCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        return tepTable
    }()
    
    
}
