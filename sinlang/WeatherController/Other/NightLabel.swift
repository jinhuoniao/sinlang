//
//  NightLabel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class NightLabel: UILabel {

    let imgView = UIImageView()
    let weatherL = UILabel()
    let directL = UILabel()
    let windL = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(imgView)
        self.addSubview(weatherL)
        self.addSubview(directL)
        self.addSubview(windL)
        
        weatherL.textColor = UIColor.whiteColor()
        weatherL.textAlignment = .Center
        weatherL.font = UIFont.boldSystemFontOfSize(20)
        directL.textColor = UIColor.whiteColor()
        directL.textAlignment = .Center
        directL.font = UIFont.systemFontOfSize(20)
        windL.textAlignment = .Center
        windL.textColor = UIColor.whiteColor()
        windL.font = UIFont.systemFontOfSize(20)
        
        imgView.sd_layout().leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightRatioToView(self, 2 / 5)
        weatherL.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.imgView, 0).heightRatioToView(self, 1 / 5)
        directL.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.weatherL, 0).heightRatioToView(self, 1 / 5)
        windL.sd_layout().leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightRatioToView(self, 1 / 5)
        
    }
}
