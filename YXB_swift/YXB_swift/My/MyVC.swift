//
//  MyVC.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class MyVC: FirstBaseVC {

    let myView : MyView = MyView(frame: CGRect(x: 0, y: 64, width: SCREENWIDTH, height: SCREENHEIGHT-64-49))
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title="我的"
        
        
        myView.backgroundColor = .red
        self.view.addSubview(myView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myView.myTable.reloadData()
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
