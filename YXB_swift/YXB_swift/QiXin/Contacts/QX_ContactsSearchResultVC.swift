//
//  QX_ContactsSearchResultVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/6.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class QX_ContactsSearchResultVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

        
    var dataList: [QX_ContactsListInfoModel]? {
        didSet{
            self.contactsTable.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.contactsTable)
        self.automaticallyAdjustsScrollViewInsets=false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //TODO:delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataList==nil ? 0:(dataList?.count)!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:QX_ContactsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QX_ContactsCell
        
        cell.setContactsCellUI(model: (dataList?[indexPath.row])!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = false
    }

    
    //lazy
    lazy var contactsTable: UITableView = {
        var tepTable : UITableView = UITableView(frame: CGRect(x:0.0, y:44.0 ,width:self.view.frame.size.width, height:self.view.frame.size.height), style: UITableViewStyle.grouped)
        tepTable.delegate = self
        tepTable.dataSource = self
        tepTable.backgroundColor = UIColor.lightGray
      
        
        let nib : UINib = UINib(nibName: "QX_ContactsCell", bundle: nil)
        tepTable.register(nib, forCellReuseIdentifier: "cell")
        return tepTable
    }()

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
