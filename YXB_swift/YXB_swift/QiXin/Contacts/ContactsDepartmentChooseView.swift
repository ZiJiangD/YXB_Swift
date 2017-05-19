//
//  ContactsDepartmentChoseView.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/8.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import UIKit

class ContactsDepartmentChooseView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    /// 点击了 第几个组织
    var selectOrgTitle_Block: ((Int) -> ())?
    private var CD_collection: UICollectionView?
    var dataSource:[String]?{
        didSet{
            self.dataList=self.dataSource!
            self.CD_collection?.reloadData()
        }
    }
    
    private var dataList:[String]=Array()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        //colloction init
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        
        CD_collection = UICollectionView.init(frame: CGRect(x:0.0,y:0.0,width: frame.size.width, height:frame.size.height-5), collectionViewLayout: layout)
        CD_collection?.delegate=self
        CD_collection?.dataSource=self
        CD_collection?.backgroundColor=UIColor.white;
        self.addSubview(self.CD_collection!);
        
        
        CD_collection?.register(UINib(nibName: "ContactsDepartmentChooseCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //TODO:Delegate
    
    //MARK:UICollection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ContactsDepartmentChooseCell? = CD_collection?.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ContactsDepartmentChooseCell?

        cell?.setCellUI(indexPath:indexPath,title:(dataList[indexPath.row]),islightColor:(indexPath.row+1==dataList.count ? false : true));
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != dataList.count-1 {
            selectOrgTitle_Block!(indexPath.row)
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let W = 30.0+String.calculationWidth(withText: dataList[indexPath.row], andFontSize: 15, andWithHeight: 23.0)
        
        return CGSize(width: W, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)//UIEdgeInsetsMake(CGFloat(SCREENWIDTH/12.0), CGFloat(SCREENWIDTH/12.0), CGFloat(SCREENWIDTH/12.0),CGFloat(SCREENWIDTH/12.0))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0//CGFloat(CGFloat(SCREENWIDTH/12.0))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0//CGFloat(CGFloat(SCREENWIDTH/12.0))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
