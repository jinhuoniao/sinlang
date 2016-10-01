//
//  ThreeButton.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ThreeButton: UIButton {

    var numLabel = UILabel()
    var explainLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.numLabel = UILabel.init(frame: CGRectMake(self.width / 3, self.height / 4, self.width / 2, self.height / 4))
        self.explainLabel = UILabel.init(frame: CGRectMake(self.width / 3, self.height / 2, self.width / 2, self.height / 4))
        
        
        numLabel.textColor = UIColor.whiteColor()
        numLabel.font = UIFont.boldSystemFontOfSize(14)
        numLabel.textAlignment = .Center
        
        
        explainLabel.textColor = UIColor.whiteColor()
        explainLabel.font = UIFont.systemFontOfSize(12)
        explainLabel.textAlignment = .Center
        
        
        self.addSubview(numLabel)
        self.addSubview(explainLabel)
    }

}
