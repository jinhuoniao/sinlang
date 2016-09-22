//
//  LeftCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LeftCell: UITableViewCell {

    var avator = UIImageView()
    var textL = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.createViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        self.addSubview(avator)
        self.addSubview(textL)
        
        textL.backgroundColor = UIColor.blueColor()
        textL.textColor = UIColor.whiteColor()
        textL.font = UIFont.boldSystemFontOfSize(15)
        
        avator.sd_layout().leftEqualToView(self).centerYEqualToView(self).widthIs(40).heightIs(40)
        avator.sd_cornerRadius = 20
        textL.sd_layout().leftSpaceToView(self.avator, aSpace).rightSpaceToView(self, 60).topSpaceToView(self, aSpace).bottomSpaceToView(self, aSpace)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
