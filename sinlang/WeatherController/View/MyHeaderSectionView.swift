//
//  MyHeaderSectionView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyHeaderSectionView: UIView {

    let tmpBtn = ThreeButton.init(frame: CGRectMake(0, 0, SCREEN_W / 3, 60))
    let winBtn = ThreeButton.init(frame: CGRectMake(0, 0, SCREEN_W / 3, 60))
    let clothesBtn = ThreeButton.init(frame: CGRectMake(0, 0, SCREEN_W / 3, 60))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(tmpBtn)
        self.addSubview(winBtn)
        self.addSubview(clothesBtn)
        
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.tmpBtn.explainLabel.text = "13~25℃"
        self.tmpBtn.numLabel.text = "预报"
        winBtn.numLabel.text = "气象"
        winBtn.explainLabel.text = "北风微风"
        clothesBtn.numLabel.text = "穿衣"
        clothesBtn.explainLabel.text = "衬衫"
        
        tmpBtn.sd_layout().leftEqualToView(self).topEqualToView(self).bottomEqualToView(self).widthRatioToView(self, 1/3)
        winBtn.sd_layout().topEqualToView(self).bottomEqualToView(self).leftSpaceToView(self.tmpBtn, 0).widthRatioToView(self, 1/3)
        clothesBtn.sd_layout().topEqualToView(self).rightEqualToView(self).bottomEqualToView(self).widthRatioToView(self, 1/3)
        
    }
    

}












