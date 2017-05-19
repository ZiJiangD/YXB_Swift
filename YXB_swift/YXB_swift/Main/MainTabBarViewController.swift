//
//  WSJTabBarVC.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/6.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit


class MainTabBarViewController: UITabBarController,ZYTTabBarDelegate {

    private var costomTabBar: ZYTTabBar?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpTabBar()
        self.setUpAllChildViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //取出系统自带的tabbar并把里面的按钮删除掉
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for child in self.tabBar.subviews {
            if !(child is YXB_swift.ZYTTabBar) {
                child.removeFromSuperview()
            }
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for child in self.tabBar.subviews {
            if !(child is YXB_swift.ZYTTabBar) {
                child.removeFromSuperview()
            }
        }
    }
    
    
    
    private func setGotoTabBarControllerOfSelectedViewController(withDic m_dic: [String: Any]) -> Void {
        let nav: ZYTNavigationVC? = (self.selectedViewController as? ZYTNavigationVC)
        
        /*
         title 标题
         content 消息体
         type 消息类型 1:商品订单 ,2:消费券订单, 3: 商品评价
         bId 业务id
         */
//        switch (m_dic["type"] as! String)  {
//        case "1":
//            delog("1")
//            let dingDangVC = ShangPingDingDanVC()
//            nav?.pushViewController(dingDangVC, animated: true)
//        case "2":
//            delog("2")
//            let xiaoFeiJuanVC = XiaoFeiJuanVC()
//            nav?.pushViewController(xiaoFeiJuanVC, animated: true)
//        case "3":
//            delog("3")
//            let detailVc = OrderDetailVC()
//            detailVc.prdId = m_dic["bId"] as! String
//            if detailVc.prdId != nil && detailVc.prdId != "0" {
//                nav?.pushViewController(detailVc, animated: true)
//            }
//            
//            
//        default:
//            delog("default")
//        }
        
    }
    
    
    
    private func setUpTabBar() -> Void {
        let newCustomTabBar = ZYTTabBar()
        newCustomTabBar.delegate = self;
        newCustomTabBar.frame = self.tabBar.bounds
        self.costomTabBar = newCustomTabBar
        self.tabBar.addSubview(newCustomTabBar)
    }
    
    
    
    func setUpAllChildViewController() -> Void {
        let qx_VC  = QiXinVC()
        self.setUpChildViewController(controller: qx_VC, title: "企信", imageName: "Chat", seleceImageName: "Chat01")
        
        let crm_VC = CRMVC()
        self.setUpChildViewController(controller: crm_VC, title: "CRM", imageName: "CRM", seleceImageName: "CRM01")
        
        let wc_VC = WorkCircleVC()
        self.setUpChildViewController(controller: wc_VC, title: "工作圈", imageName: "job", seleceImageName: "job01")
        
        let w_VC = WorkVC()
        self.setUpChildViewController(controller: w_VC, title: "工作", imageName: "work", seleceImageName: "work01")
        
        let my_VC = MyVC()
        self.setUpChildViewController(controller: my_VC, title: "我的", imageName: "man", seleceImageName: "man01")
        
        
    }
    
    private func setUpChildViewController(controller: UIViewController, title: String, imageName: String, seleceImageName selectImageName: String) -> Void {
        
        controller.tabBarItem.title = title
        //跟上面一样效果
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: selectImageName)
        //包装导航控制器
        let nav = ZYTNavigationVC(rootViewController: controller)
        nav.navigationBar.barTintColor = navigationBarColor
        nav.navigationBar.isTranslucent = true
        //关闭半透明效果
        let dict: [String: Any] = [ NSForegroundColorAttributeName : UIColor.white ]
        nav.navigationBar.titleTextAttributes=dict
        //修改navigationBar 的 title颜色
        self.addChildViewController(nav)
        self.costomTabBar?.addTabBarButton(WithItem: controller.tabBarItem)
    }
    
//TODO:Delegate

    //MARK:ZYTTabBarDelegate
    func tabBarDidSelect(tabBar: ZYTTabBar, from: Int, to: Int) {
        delog("(\(from),\(to))")
        self.selectedIndex = to
        delog("\(self.selectedIndex)")
    }



}
