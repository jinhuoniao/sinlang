//
//  MeButton.swift
//  weibolx
//
//  Created by qianfeng on 16/9/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeButton: UIButton {

    var numLabel = UILabel()
    var explainLabel = UILabel()
    
    
    override func layoutSubviews() {
        self.numLabel = UILabel.init(frame: CGRectMake(self.width / 3, self.height / 4, self.width / 3, self.height / 4))
        self.explainLabel = UILabel.init(frame: CGRectMake(self.width / 3, self.height / 2, self.width / 3, self.height / 4))
        
        
        
        
        numLabel.textColor = UIColor.blackColor()
        numLabel.font = UIFont.boldSystemFontOfSize(14)
        numLabel.textAlignment = .Center

        
        
        explainLabel.textColor = UIColor.blackColor()
        explainLabel.font = UIFont.systemFontOfSize(12)
        explainLabel.textAlignment = .Center
        
        
        self.addSubview(numLabel)
        self.addSubview(explainLabel)
        
    }
    

}
