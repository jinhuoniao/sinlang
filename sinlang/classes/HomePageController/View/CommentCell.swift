//
//  CommentCell.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    
    var iconView = UIImageView()
    var nameB = UIButton.init(type: .Custom)
    var timeL = UILabel()
    var textL = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.addSubview(iconView)
        self.addSubview(nameB)
        self.addSubview(timeL)
        self.addSubview(textL)
        
        nameB.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        nameB.setTitleColor(UIColor.blueColor(), forState: .Normal)
        nameB.contentHorizontalAlignment = .Left
        
        timeL.font = UIFont.systemFontOfSize(12)
        timeL.textColor = UIColor.grayColor()
        
        textL.font = UIFont.boldSystemFontOfSize(18)
        textL.textColor = UIColor.blackColor()
        textL.numberOfLines = 0
        
        
        iconView.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self, aSpace).widthIs(50).heightIs(50)
        nameB.sd_layout().leftSpaceToView(self.iconView, aSpace).topSpaceToView(self,aSpace).heightIs(30).rightEqualToView(self)
        timeL.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self.nameB, 0).heightIs(20).rightEqualToView(self)
        
        textL.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self.iconView,bSpace).rightSpaceToView(self, aSpace).bottomSpaceToView(self, bSpace)
        
    }
}
