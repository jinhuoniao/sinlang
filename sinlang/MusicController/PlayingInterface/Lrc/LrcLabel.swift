//
//  LrcLabel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LrcLabel: UILabel {

    var progress: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let drawR = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height)
        UIColor.redColor().set()
        UIRectFillUsingBlendMode(drawR, .SourceIn)
    }

}
