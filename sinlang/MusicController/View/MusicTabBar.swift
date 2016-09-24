//
//  MusicTabBar.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MusicTabBar: UITabBar {

    let tabView = UIView()
    let iconImage = UIImageView()
    let slider = UISlider.init(frame: CGRectMake(0, 0, 0, 10))
    let songNameL = UILabel()
    let singerNameL = UILabel()
    
    let playBtn = UIButton.init(type: .Custom)
    let upBtn = UIButton.init(type: .Custom)
    let nextBtn = UIButton.init(type: .Custom)
    let menuListBtn = UIButton.init(type: .Custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
        self.userInteractionEnabled = true
        tabView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap))
        tabView.addGestureRecognizer(tap)
    }
    
    func tap() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        self.addSubview(tabView)
        self.tabView.addSubview(iconImage)
        self.tabView.addSubview(slider)
        self.tabView.addSubview(songNameL)
        self.tabView.addSubview(singerNameL)
        self.tabView.addSubview(menuListBtn)
        self.tabView.addSubview(nextBtn)
        self.tabView.addSubview(playBtn)
        self.tabView.addSubview(upBtn)
        
        slider.userInteractionEnabled = true
        slider.setThumbImage(UIImage.init(named: "thumb"), forState: .Normal)
        
        songNameL.font = UIFont.boldSystemFontOfSize(20)
        songNameL.textColor = UIColor.blackColor()
        
        singerNameL.font = UIFont.boldSystemFontOfSize(18)
        singerNameL.textColor = UIColor.grayColor()
        
        iconImage.backgroundColor = UIColor.blueColor()
        songNameL.backgroundColor = UIColor.blackColor()
        singerNameL.backgroundColor = UIColor.grayColor()
        menuListBtn.backgroundColor = UIColor.blackColor()
        nextBtn.backgroundColor = UIColor.greenColor()
        playBtn.backgroundColor = UIColor.blueColor()
        upBtn.backgroundColor = UIColor.orangeColor()
        
        tabView.sd_layout().leftEqualToView(self).topEqualToView(self).rightEqualToView(self).bottomEqualToView(self)
        iconImage.sd_layout().leftEqualToView(self.tabView).bottomEqualToView(self.tabView).widthIs(60).heightIs(60)
        iconImage.sd_cornerRadius = 30
        slider.sd_layout().leftSpaceToView(self.iconImage, aSpace).topSpaceToView(self.tabView, -5).rightSpaceToView(self.tabView, aSpace)
        songNameL.sd_layout().leftSpaceToView(self.iconImage, aSpace).bottomSpaceToView(self.singerNameL, 0).heightIs(20).widthIs(150)
        singerNameL.sd_layout().leftSpaceToView(self.iconImage, aSpace).bottomSpaceToView(self.tabView, 0).widthIs(150).heightIs(15)
        
        menuListBtn.sd_layout().rightSpaceToView(self.tabView, 2).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        nextBtn.sd_layout().rightSpaceToView(self.menuListBtn, aSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        playBtn.sd_layout().rightSpaceToView(self.nextBtn, aSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        upBtn.sd_layout().rightSpaceToView(self.playBtn,aSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        
        menuListBtn.addTarget(self, action: #selector(self.tap), forControlEvents: .TouchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for tabBarButton in self.subviews {
            if "\(tabBarButton.classForCoder)" != "UITabBarButton" {
                continue
            }
            tabBarButton.userInteractionEnabled = false
        }
    }
    

}





















