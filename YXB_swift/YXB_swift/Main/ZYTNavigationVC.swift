//
//  ZYTNavigationVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/9.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class ZYTNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = YXBMainColor
        // Do any additional setup after loading the view.
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

}
