//
//  ZYTTabBar.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/6.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

protocol ZYTTabBarDelegate {
    
    /// ZYTTabBarDelegate 代理方法
    ///
    /// - Parameters:
    ///   - tabBar: ZYTTabBar
    ///   - from: 从哪
    ///   - to: 到哪
    func tabBarDidSelect(tabBar: ZYTTabBar, from: Int ,to: Int)
}

class ZYTTabBar: UIView {

    
    var selectedButton: ZYTTabBarButton?
    var delegate: ZYTTabBarDelegate?;//代理
    
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedButton = ZYTTabBarButton()
        self.backgroundColor = UIColor.white;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addTabBarButton(WithItem item : UITabBarItem ) -> Void {
        
        let tempButton = ZYTTabBarButton()
        self.addSubview(tempButton)
        
        tempButton.item = item
        tempButton.addTarget(self, action:#selector(buttonClick(button:)), for: .touchDown)
        
        if self.subviews.count == 1 {
            self.buttonClick(button: tempButton)
        }
    }
    
    
    func setSelectedIndexButton(WithTag index : Int) -> Void {
        if index == 0 {
            let button: ZYTTabBarButton? = self.subviews[0] as? ZYTTabBarButton
            self.buttonClick(button: button!);
            
        }else{
            let button: ZYTTabBarButton? = self.subviews[index] as? ZYTTabBarButton
            self.buttonClick(button: button!);
        }
    }
    
     func buttonClick(button: ZYTTabBarButton) -> Void {
        
//        let canDo: Bool = ((delegate?.tabBarDidSelect(tabBar: self, from: (self.selectedButton?.tag)!, to: button.tag)) != nil)
        

        let mytag = self.selectedButton?.tag
            delegate?.tabBarDidSelect(tabBar: self, from: mytag!, to: button.tag)
        self.selectedButton?.isSelected = false
        button.isSelected=true
        self.selectedButton = button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonW :CGFloat = self.frame.size.width / CGFloat(self.subviews.count)
        let buttonH :CGFloat = self.frame.size.height
        let buttonY :CGFloat = CGFloat(0)
        
        for index  in 0..<self.subviews.count {
            let button: ZYTTabBarButton? = self.subviews[index] as? ZYTTabBarButton
            let buttonX :CGFloat = CGFloat(index) * buttonW
            
            button?.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            button?.tag = index
            
        }
        
        
    }

}
