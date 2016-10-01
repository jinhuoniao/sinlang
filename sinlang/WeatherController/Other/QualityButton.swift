//
//  QualityButton.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class QualityButton: UIButton {

    var numL = UILabel()
    var descL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        numL = UILabel.init(frame: CGRectMake(0, 0, self.width, self.height * 2 / 3))
        descL = UILabel.init(frame: CGRectMake(0, self.height * 2 / 3, self.width, self.height / 3))
        
        
        self.addSubview(numL)
        self.addSubview(descL)
        
        numL.text = "69"
        numL.textAlignment = .Center
        numL.textColor = UIColor.whiteColor()
        numL.font = UIFont.boldSystemFontOfSize(40)
        descL.text = "空气良"
        descL.textColor = UIColor.whiteColor()
        descL.font = UIFont.systemFontOfSize(15)
        descL.textAlignment = .Center
        descL.backgroundColor = UIColor.orangeColor()
    }

}
