//
//  WeatherHeaderView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {

    let calenderL1 = UILabel()
    let calenderL2 = UILabel()
    let cartoonBtn = UIButton.init(type: .Custom)
    let qualityBtn = QualityButton.init(frame: CGRectMake(0, 0, 80, 80))
    let weatherBtn = WeatherButton.init(frame: CGRectMake(0, 0, 200, 200))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(calenderL1)
        self.addSubview(calenderL2)
        self.addSubview(cartoonBtn)
        self.addSubview(qualityBtn)
        self.addSubview(weatherBtn)
        
        
        calenderL1.text = "九月29日"
        calenderL1.textColor = UIColor.whiteColor()
        calenderL1.font = UIFont.systemFontOfSize(15)
        calenderL1.textAlignment = .Right
        calenderL2.text = "农历十二月三十"
        calenderL2.textAlignment = .Right
        calenderL2.textColor = UIColor.whiteColor()
        calenderL2.font = UIFont.systemFontOfSize(15)
        
        qualityBtn.layer.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2).CGColor
        
        calenderL2.sd_layout().rightSpaceToView(self, bSpace).topSpaceToView(self, bSpace).heightIs(20).widthIs(110)
        calenderL1.sd_layout().topSpaceToView(self, bSpace).rightSpaceToView(self.calenderL2, bSpace).widthIs(100).heightIs(20)
        qualityBtn.sd_layout().rightSpaceToView(self, bSpace).topSpaceToView(self.calenderL2, bSpace).widthIs(80).heightIs(80)
        cartoonBtn.sd_layout().rightSpaceToView(self.qualityBtn, bSpace).topSpaceToView(self.calenderL2, bSpace).widthIs(100).heightIs(100)
        weatherBtn.sd_layout().bottomSpaceToView(self, bSpace).leftSpaceToView(self, bSpace).widthIs(200).heightIs(200)
        
        
    }

}
