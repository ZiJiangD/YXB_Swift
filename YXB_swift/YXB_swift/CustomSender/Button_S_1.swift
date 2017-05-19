//
//  Button_S_1.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class Button_S_1: UIButton {


    
    
    var myTitleStr : String? {
        didSet{
            myTitleLabel.text = self.myTitleStr
            self.updateFrame()
        }
    }
    
    var isShowBadge : Bool? {
        didSet{
            badeImageView.isHidden = !self.isShowBadge!
        }
    }
    
    var isShowBottomView : Bool? {
        didSet{
            bottomView.isHidden = !self.isShowBottomView!
        }
    }
    override var isSelected: Bool{
        didSet{
            if isSelected {
                myTitleLabel.textColor = UIColor.white
                bottomView.isHidden = false
            }else{
                myTitleLabel.textColor = UIColor.lightGray
                bottomView.isHidden = true
            }
        }
    }
    
    
    lazy private var myTitleLabel : UILabel = {
        var tepLab = UILabel()
        tepLab.font=UIFont.systemFont(ofSize: 15)
        tepLab.textAlignment = NSTextAlignment.center
        tepLab.text = "title"
        tepLab.textColor = UIColor.lightGray
        return tepLab
    }()
    lazy private var badeImageView : UIImageView = {
        var tepImageView = UIImageView()
        tepImageView.image = UIImage(named: "tishi")
        tepImageView.isHidden = true
        return tepImageView
    }()
    lazy private var bottomView : UIView = {
        var tepBottomView = UIView()
        tepBottomView.isHidden = true
        tepBottomView.backgroundColor = UIColor.white
        return tepBottomView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("", for: .normal)
        self.addSubview(myTitleLabel)
        self.addSubview(badeImageView)
        self.addSubview(bottomView)
        self.updateFrame()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.setTitle("", for: .normal)
        self.addSubview(self.myTitleLabel)
        self.addSubview(self.badeImageView)
        self.addSubview(self.bottomView)
        self.updateFrame()
    }
    
    override var frame : CGRect {
        didSet{
            self.updateFrame()
        }
    }
    
    
    private func updateFrame() -> Void {
        self.setTitle("", for: .normal)
        self.layoutIfNeeded()
        let p : CGFloat = 1.0
        let h = self.frame.size.height
        let w = self.frame.size.width
        
        myTitleLabel.frame = CGRect(x: 0.0, y: 0.0, width: (w-5.0)*p, height: h-5)
        let t_w=String.calculationWidth(withText: myTitleLabel.text, andFontSize: myTitleLabel.font.pointSize, andWithHeight: myTitleLabel.frame.size.height)
        myTitleLabel.frame = CGRect(x: 0.0, y: 0.0, width: t_w, height: h-5)
        
        badeImageView.frame = CGRect(x: myTitleLabel.frame.maxX, y: 3.0, width: 5.0, height: 5.0)
        bottomView.frame = CGRect(x: 0, y: myTitleLabel.frame.maxY+2, width: t_w+5.0, height: 1)
        self.reloadInputViews()
        
    }
}
