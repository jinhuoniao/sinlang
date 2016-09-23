//
//  PublishButton.swift
//  sinlang
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PublishButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.origin.y = 0
        self.imageView?.centerX = self.width * 0.5
        self.titleLabel?.width = self.width
        self.titleLabel?.origin.y = CGRectGetMaxY((self.imageView?.frame)!)
        self.titleLabel?.origin.x = 0
        self.titleLabel?.height = self.height - (self.titleLabel?.origin.y)!
    }
}
