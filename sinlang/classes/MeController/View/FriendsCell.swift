//
//  FriendsCell.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {

    var iconView = UIImageView()
    var nameB = UIButton.init(type: .Custom)
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
        self.addSubview(textL)
        
        iconView.clipsToBounds = true
        
        nameB.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        nameB.setTitleColor(UIColor.blueColor(), forState: .Normal)
        nameB.contentHorizontalAlignment = .Left
        
        
        textL.font = UIFont.boldSystemFontOfSize(15)
        textL.textColor = UIColor.blackColor()
        textL.numberOfLines = 1
        
        
        iconView.sd_cornerRadius = 25
        iconView.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self, aSpace).widthIs(50).heightIs(50)
        nameB.sd_layout().leftSpaceToView(self.iconView, aSpace).topSpaceToView(self,aSpace).heightIs(30).rightEqualToView(self)
        
        textL.sd_layout().leftSpaceToView(self.iconView, aSpace).topSpaceToView(self.nameB,bSpace).rightSpaceToView(self, 50).bottomSpaceToView(self, bSpace)
        
    }


}
