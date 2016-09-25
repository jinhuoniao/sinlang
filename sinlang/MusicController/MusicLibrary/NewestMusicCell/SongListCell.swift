//
//  SongListCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SongListCell: UITableViewCell {

    let leftView = UIView()
    let adBtn = UIButton.init(type: .Custom)
    let songL = UILabel()
    let nameL = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(leftView)
        self.addSubview(adBtn)
        self.addSubview(songL)
        self.addSubview(nameL)
        
        songL.textColor = UIColor.blackColor()
        songL.font = UIFont.boldSystemFontOfSize(20)
        nameL.textColor = UIColor.grayColor()
        nameL.font = UIFont.systemFontOfSize(15)
        
        songL.sd_layout().leftSpaceToView(self, 50).topSpaceToView(self, aSpace).heightIs(30).widthIs(300)
        nameL.sd_layout().leftSpaceToView(self, 50).topSpaceToView(self.songL, 0).heightIs(20).widthIs(300)
    }
}
