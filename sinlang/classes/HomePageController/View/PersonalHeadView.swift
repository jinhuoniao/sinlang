//
//  PersonalHeadView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PersonalHeadView: UIView {

    var iconImage = UIImageView()
    var screenNameL = UILabel()
    var genderL = UILabel()
    var friendsL = UILabel()
    var followL = UILabel()
    var coverImageL = UIImageView()
    var localtionL = UILabel()
    var chatBtn = UIButton.init(type: .Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatSubviews() {
        self.addSubview(coverImageL)
        self.addSubview(iconImage)
        self.addSubview(screenNameL)
        self.addSubview(genderL)
        self.addSubview(friendsL)
        self.addSubview(followL)
        self.addSubview(localtionL)
        self.addSubview(chatBtn)
        
        screenNameL.textColor = UIColor.whiteColor()
        screenNameL.font = UIFont.boldSystemFontOfSize(20)
        
        genderL.textColor = UIColor.whiteColor()
        genderL.font = UIFont.systemFontOfSize(15)
        
        localtionL.textColor = UIColor.whiteColor()
        localtionL.font = UIFont.systemFontOfSize(15)
        
        chatBtn.setTitle("私聊", forState: .Normal)
        chatBtn.backgroundColor = UIColor.yellowColor()
        chatBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        chatBtn.titleLabel?.font = UIFont.systemFontOfSize(20)
        
        
        coverImageL.sd_layout().leftEqualToView(self).topEqualToView(self).rightEqualToView(self).bottomEqualToView(self)
        iconImage.sd_layout().topSpaceToView(self,20).widthIs(80).heightIs(80).centerXEqualToView(self)
        iconImage.sd_cornerRadius = 40
        screenNameL.sd_layout().topSpaceToView(self.iconImage,20).centerXEqualToView(self.iconImage).heightIs(25).widthIs(80)
        genderL.sd_layout().leftSpaceToView(self.screenNameL, 5).topSpaceToView(self.iconImage, 20).widthIs(23).heightIs(23)
        localtionL.sd_layout().leftSpaceToView(self.genderL, 5).topSpaceToView(self.iconImage, 20).widthIs(80).heightIs(23)
        chatBtn.sd_layout().leftEqualToView(self).bottomEqualToView(self).widthIs(100).heightIs(30)
        
    }

}
