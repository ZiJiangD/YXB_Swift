//
//  SecondBaseVC.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/7.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class SecondBaseVC: UIViewController {
    
    var backButton : UIButton?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor=UIColor.white;
        self.createBaseVCNavigationView()
        self.automaticallyAdjustsScrollViewInsets=false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBaseVCNavigationView() -> Void {
        backButton = UIButton(type: .custom)
        backButton?.frame=CGRect(x: 0, y: 27, width: 84, height: 24)
        backButton?.titleLabel?.adjustsFontSizeToFitWidth=true//UIButton内文字自适应Button长度
        
        var vcList: [UIViewController] = self.navigationController!.viewControllers
        let tmpVC: UIViewController? = vcList[vcList.count - 2]
        var navBarTitle: String? = tmpVC?.title
        
        if !(((navBarTitle?.characters) != nil)) {
            navBarTitle = tmpVC?.navigationItem.title ?? ""
        }
        backButton?.setTitle(navBarTitle, for: .normal)
        backButton?.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(16))
        backButton?.contentHorizontalAlignment = .left
        backButton?.setTitleColor(UIColor.white, for: .normal)
        backButton?.setImage(UIImage(named: "back"), for: .normal)
        backButton?.imageEdgeInsets = UIEdgeInsets(top: CGFloat(0), left: CGFloat(-12), bottom: CGFloat(0), right: CGFloat(0))
        backButton?.titleEdgeInsets = UIEdgeInsets(top: CGFloat(0), left: CGFloat(-9), bottom: CGFloat(0), right: CGFloat(0))
        backButton?.addTarget(self, action: #selector(backButtonOnClick(button:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton!)
    }

    
    func backButtonOnClick(button: UIButton) -> Void {
        self.hidesBottomBarWhenPushed = false
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    func showToast(_ messageStr : String?) -> Void {
        String.showTost(messageStr!)
    }
    
    func showAlertWithContext(_ text: String?) -> Void {
        let alert: UIAlertView = UIAlertView(title: "", message: text, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        Common().findHairlineImageViewUnder((self.navigationController?.navigationBar)!)?.isHidden = true
    }

}
