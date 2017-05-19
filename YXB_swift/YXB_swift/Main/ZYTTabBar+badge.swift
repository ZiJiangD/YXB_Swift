//
//  ZYTTabBar+badge.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/6.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation
import UIKit
let TabbarItemNums = 5.0
extension ZYTTabBar{
    func showBadge(onItemIndex index: Int) -> Void {
        self.removeBadge(onItemIndex: index)
        
        //新建小红点
        let badgeView : UIView = UIView()
        badgeView.tag = 888+index
        badgeView.layer.cornerRadius = CGFloat(5)
        badgeView.backgroundColor=UIColor.red
        let tabFrame : CGRect = self.frame
        
        let percentX : Float = (Float(index) + 0.6) / Float(TabbarItemNums)
        let x: CGFloat = CGFloat(ceilf(percentX * Float(tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.1) * Float(tabFrame.size.height)))
        
        badgeView.frame=CGRect(x: x, y: y, width: CGFloat(10), height: CGFloat(10))
        self.addSubview(badgeView);
        
        
    }
    
    
    /// 影藏小红点
    func hideBadge(onItemIndex index:Int) -> Void {
        self.removeBadge(onItemIndex: index)
    }
    private func removeBadge(onItemIndex index: Int) -> Void {
        for subView: UIView in self.subviews {
            
            if subView.tag == 888+index {
                subView.removeFromSuperview()
            }
        }
    }
}
