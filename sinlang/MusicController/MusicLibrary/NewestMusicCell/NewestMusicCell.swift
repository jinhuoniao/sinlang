//
//  NewestMusicCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class NewestMusicCell: UITableViewCell {

    let iconImage = UIImageView()
    let titleL = UILabel()
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(iconImage)
        self.addSubview(titleL)
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        
        titleL.textColor = UIColor.blackColor()
        titleL.font = UIFont.boldSystemFontOfSize(20)
        label1.textColor = TEXTGRAYCOLOR
        label1.font = UIFont.systemFontOfSize(15)
        label2.textColor = TEXTGRAYCOLOR
        label2.font = UIFont.systemFontOfSize(15)
        label3.textColor = TEXTGRAYCOLOR
        label3.font = UIFont.systemFontOfSize(15)
        
        iconImage.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self, aSpace).bottomSpaceToView(self, aSpace).widthIs(75)
        titleL.sd_layout().leftSpaceToView(self.iconImage, aSpace).topSpaceToView(self, aSpace).heightIs(30).widthIs(100)
        label1.sd_layout().leftSpaceToView(self.iconImage, 5).topSpaceToView(self.titleL, aSpace).widthIs(300).heightIs(15)
        label2.sd_layout().leftSpaceToView(self.iconImage, aSpace).topSpaceToView(self.label1, aSpace).widthIs(300).heightIs(15)
        label3.sd_layout().leftSpaceToView(self.iconImage, aSpace).topSpaceToView(self.label2, aSpace).widthIs(300).heightIs(15)
        
        
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
