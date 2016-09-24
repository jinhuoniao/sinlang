//
//  HearController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HearController: UICollectionViewCell {
    
    let view1 = UIView()
    let likeBtn = PublishButton()
    let menuBtn = PublishButton()
    let loadBtn = PublishButton()
    let recentBtn = PublishButton()
    
    let view2 = UIView()
    let musicLibraryBtn = PublishButton()
    let radioStationBtn = PublishButton()
    let coolGroupBtn = PublishButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        self.addSubview(view1)
        self.view1.addSubview(likeBtn)
        self.view1.addSubview(menuBtn)
        self.view1.addSubview(loadBtn)
        self.view1.addSubview(recentBtn)
        
        self.view1.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        likeBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        likeBtn.setTitle("喜欢", forState: .Normal)
        menuBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        menuBtn.setTitle("歌单", forState: .Normal)
        loadBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        loadBtn.setTitle("下载", forState: .Normal)
        recentBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        recentBtn.setTitle("最近", forState: .Normal)
        
        view1.sd_layout().topSpaceToView(self, 0).leftEqualToView(self).rightEqualToView(self).heightIs(100)
        likeBtn.sd_layout().topSpaceToView(self.view1, aSpace).leftEqualToView(self.view1).bottomEqualToView(self.view1).widthRatioToView(self.view1, 1 / 4)
        menuBtn.sd_layout().topSpaceToView(self.view1, aSpace).bottomEqualToView(self.view1).leftSpaceToView(self.likeBtn, 0).widthRatioToView(self.view1, 1 / 4)
        loadBtn.sd_layout().topSpaceToView(self.view1, aSpace).bottomEqualToView(self.view1).leftSpaceToView(self.menuBtn, 0).widthRatioToView(self.view1, 1 / 4)
        recentBtn.sd_layout().topSpaceToView(self.view1, aSpace).bottomEqualToView(self.view1).rightEqualToView(self.view1).widthRatioToView(self.view1, 1 / 4)
        
        
        self.addSubview(view2)
        self.view2.addSubview(musicLibraryBtn)
        self.view2.addSubview(radioStationBtn)
        self.view2.addSubview(coolGroupBtn)
        
        view2.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        musicLibraryBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        musicLibraryBtn.setTitle("乐库", forState: .Normal)
        musicLibraryBtn.addTarget(self, action: #selector(self.musicLibraryClick), forControlEvents: .TouchUpInside)
        radioStationBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        radioStationBtn.setTitle("电台", forState: .Normal)
        coolGroupBtn.setImage(UIImage.init(named: "icon_ios_heart_filled"), forState: .Normal)
        coolGroupBtn.setTitle("酷群", forState: .Normal)
        
        view2.sd_layout().topSpaceToView(self.view1, 20).leftEqualToView(self).rightEqualToView(self).heightIs(100)
        musicLibraryBtn.sd_layout().leftEqualToView(self.view2).topSpaceToView(self.view2, aSpace).bottomEqualToView(self.view2).widthRatioToView(self.view2, 1 / 3)
        radioStationBtn.sd_layout().leftSpaceToView(self.musicLibraryBtn, 0).topSpaceToView(self.view2, aSpace).bottomEqualToView(self.view2).widthRatioToView(self.view2, 1 / 3)
        coolGroupBtn.sd_layout().topSpaceToView(self.view2, aSpace).rightEqualToView(self.view2).bottomEqualToView(self.view2).widthRatioToView(self.view2, 1 / 3)
    }
    
    func musicLibraryClick() {
        NSNotificationCenter.defaultCenter().postNotificationName("pushToMusicLibrary", object: nil)
    }
}

























