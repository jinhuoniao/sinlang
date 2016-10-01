//
//  DayLabel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DayLabel: UILabel {

    let weekL = UILabel()
    let dateL = UILabel()
    let imgView = UIImageView()
    let weatherL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(weekL)
        self.addSubview(dateL)
        self.addSubview(imgView)
        self.addSubview(weatherL)
        
        weekL.textColor = UIColor.whiteColor()
        weekL.textAlignment = .Center
        weekL.font = UIFont.boldSystemFontOfSize(20)
        dateL.textColor = UIColor.whiteColor()
        dateL.textAlignment = .Center
        dateL.font = UIFont.systemFontOfSize(15)
        weatherL.textAlignment = .Center
        weatherL.textColor = UIColor.whiteColor()
        weatherL.font = UIFont.boldSystemFontOfSize(20)
        
        weekL.sd_layout().leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightRatioToView(self, 1 / 5)
        dateL.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.weekL, 0).heightRatioToView(self, 1 / 5)
        imgView.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.dateL, 0).heightRatioToView(self, 2 / 5)
        weatherL.sd_layout().leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightRatioToView(self, 1 / 5)
    }
}
