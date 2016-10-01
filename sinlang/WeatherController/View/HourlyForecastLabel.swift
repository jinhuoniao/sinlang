//
//  HourlyForecastLabel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HourlyForecastLabel: UIView {

    let timeL = UILabel()
    let imgView = UIImageView()
    let tmpL = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(timeL)
        self.addSubview(imgView)
        self.addSubview(tmpL)
        
        timeL.textColor = UIColor.whiteColor()
        timeL.font = UIFont.systemFontOfSize(15)
        timeL.textAlignment = .Center
        tmpL.textColor = UIColor.whiteColor()
        tmpL.font = UIFont.systemFontOfSize(15)
        tmpL.textAlignment = .Center
        
        timeL.sd_layout().leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightRatioToView(self, 1 / 4)
        imgView.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.timeL, 0).heightRatioToView(self, 1 / 2)
        tmpL.sd_layout().leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightRatioToView(self, 1 / 4)
    }
}

























