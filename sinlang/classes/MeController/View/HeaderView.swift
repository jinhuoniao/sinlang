//
//  HeaderView.swift
//  weibolx
//
//  Created by qianfeng on 16/9/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var headImage = UIImageView()
    
    var nameL = UILabel()
    var descripeL = UILabel()
    var bottomView = UIView()
    var weiboBtn = MeButton()
    var careBtn = MeButton()
    var fansBtn = MeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        headImage.backgroundColor = UIColor.blackColor()
        headImage.layer.cornerRadius = 30
        headImage.clipsToBounds = true
        
        nameL.textColor = UIColor.blackColor()
        nameL.font = UIFont.boldSystemFontOfSize(18)
        
        descripeL.textColor = UIColor.grayColor()
        descripeL.font = UIFont.systemFontOfSize(14)
        descripeL.text = "简介:"
        descripeL.numberOfLines = 2
        
        
        self.addSubview(headImage)
        self.addSubview(nameL)
        self.addSubview(descripeL)
        self.addSubview(bottomView)
        self.bottomView.addSubview(weiboBtn)
        self.bottomView.addSubview(careBtn)
        self.bottomView.addSubview(fansBtn)
        
        headImage.sd_layout().topSpaceToView(self, 25).leftSpaceToView(self, 5).widthIs(60).heightIs(60)
        nameL.sd_layout().topEqualToView(self.headImage).leftSpaceToView(self.headImage, 10).rightSpaceToView(self, 50).heightIs(20)
        descripeL.sd_layout().topSpaceToView(self.nameL, 0).leftSpaceToView(self.headImage, 10).rightSpaceToView(self, 50).heightIs(40)
        bottomView.sd_layout().topSpaceToView(self.headImage,5).leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0)
        weiboBtn.sd_layout().topSpaceToView(self.bottomView, 0).leftSpaceToView(self.bottomView, 0).bottomSpaceToView(self.bottomView, 0).widthRatioToView(self.bottomView, 1 / 3)
        careBtn.sd_layout().topSpaceToView(self.bottomView, 0).bottomSpaceToView(self.bottomView,0).leftSpaceToView(self.weiboBtn, 0).widthRatioToView(self.bottomView, 1 / 3)
        fansBtn.sd_layout().topSpaceToView(self.bottomView, 0).bottomSpaceToView(self.bottomView, 0).rightSpaceToView(self.bottomView, 0).leftSpaceToView(self.careBtn,0)
        
        
        
    }
    
    
}
