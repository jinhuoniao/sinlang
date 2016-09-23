//
//  DiscoverCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {

    var headImage = UIImageView()
    var nameL = UILabel()
    var addressL = UILabel()
    var numL = UILabel()
    var backView = UIView()
    var coverImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        self.addSubview(headImage)
        self.addSubview(nameL)
        self.addSubview(addressL)
        self.addSubview(numL)
        self.addSubview(backView)
        self.backView.addSubview(coverImage)
        
        nameL.font = UIFont.boldSystemFontOfSize(20)
        nameL.textColor = UIColor.blackColor()
        
        addressL.font = UIFont.systemFontOfSize(18)
        addressL.textColor = UIColor.grayColor()
        
        numL.font = UIFont.systemFontOfSize(18)
        numL.textColor = UIColor.blackColor()
        numL.textAlignment = .Right
        
        headImage.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self, aSpace).widthIs(70).heightIs(70)
        headImage.sd_cornerRadius = 35
        nameL.sd_layout().topSpaceToView(self, aSpace).leftSpaceToView(self.headImage, aSpace).rightSpaceToView(self, 100).heightIs(40)
        addressL.sd_layout().leftSpaceToView(self.headImage, aSpace).topSpaceToView(self.nameL, 0).rightSpaceToView(self, 100).heightIs(30)
        numL.sd_layout().rightSpaceToView(self, aSpace).widthIs(150).centerYEqualToView(self.headImage).heightIs(50)
        backView.sd_layout().topSpaceToView(self.headImage, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0)
        coverImage.sd_layout().leftEqualToView(self.backView).topEqualToView(self.backView).rightEqualToView(self.backView).bottomEqualToView(self.backView)
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
