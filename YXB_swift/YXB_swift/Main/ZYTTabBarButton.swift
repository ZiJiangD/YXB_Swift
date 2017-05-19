//
//  ZYTTabBarButton.swift
//  WSJ_swift
//
//  Created by NightOwl on 2017/3/6.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

let ZYTTabBarButtonImageRatio = 0.6
class ZYTTabBarButton: UIButton {

    var _item: UITabBarItem?
    weak var item: UITabBarItem? {
        get{
            return self.item
        }
        set(item){
            _item = item
            self.setTitle(_item?.title, for: .normal)
            self.setImage(_item?.image, for: .normal)
            self.setImage(_item?.selectedImage, for: .selected)
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        //图片居中
        self.imageView?.contentMode = .center
        //文字居中
        self.titleLabel?.textAlignment = .center
        //字体居中
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(11))
        self.setTitleColor(UIColor.gray, for: .normal)
        self.setTitleColor(tabBarColor, for: .selected)
        
        //添加一个提醒数字按钮
        let badgeButton = UIButton();
        self.addSubview(badgeButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW : CGFloat = contentRect.size.width;
        let imageH : CGFloat = contentRect.size.height * CGFloat(ZYTTabBarButtonImageRatio)
        return CGRect(x: CGFloat(0), y: CGFloat(4), width: imageW, height: imageH)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let titleX : CGFloat = CGFloat(0)
        let titleY : CGFloat = contentRect.size.height * CGFloat(ZYTTabBarButtonImageRatio)
        let titleW : CGFloat = contentRect.size.width;
        let titleH : CGFloat = contentRect.size.height - titleY
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    
}
