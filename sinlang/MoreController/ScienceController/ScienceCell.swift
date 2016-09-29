//
//  ScienceCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ScienceCell: UITableViewCell {

    let titleL = UILabel()
    let timeL = UILabel()
    let picView = UIImageView()
    let descL = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(titleL)
        self.addSubview(timeL)
        self.addSubview(picView)
        self.addSubview(descL)
        
        descL.textColor = UIColor.blackColor()
        descL.font = UIFont.boldSystemFontOfSize(20)
        descL.textAlignment = .Right
        timeL.textColor = UIColor.grayColor()
        timeL.font = UIFont.systemFontOfSize(15)
        timeL.textAlignment = .Right
        titleL.textColor = UIColor.blackColor()
        titleL.font = UIFont.boldSystemFontOfSize(18)
        titleL.numberOfLines = 2
        
        
        descL.sd_layout().rightSpaceToView(self, aSpace).topEqualToView(self).widthIs(100).heightIs(30)
        timeL.sd_layout().rightSpaceToView(self, aSpace).topSpaceToView(self.descL,2).widthIs(150).heightIs(20)
        titleL.sd_layout().topEqualToView(self).leftEqualToView(self).rightSpaceToView(self.descL, aSpace).heightIs(50)
        picView.sd_layout().topSpaceToView(self.titleL, aSpace).leftSpaceToView(self, aSpace).widthIs(200).heightIs(200)
        
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
