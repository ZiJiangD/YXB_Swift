//
//  FirstBaseVC.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/7.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class FirstBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets=false
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor=UIColor.white;

        
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

    func showToast(_ messageStr : String?) -> Void {
        String.showTost(messageStr!)
    }
    
    func showAlertWithContext(_ text: String) -> Void {
        let alert: UIAlertView = UIAlertView(title: "", message: text, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        Common().findHairlineImageViewUnder((self.navigationController?.navigationBar)!)?.isHidden = true
    }
    
}
