//
//  WeatherCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    let titleL = UILabel()
    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(titleL)
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        
        titleL.textColor = UIColor.whiteColor()
        titleL.text = "天气预报"
        titleL.font = UIFont.boldSystemFontOfSize(20)
        
        titleL.sd_layout().leftEqualToView(self).topEqualToView(self).widthIs(100).heightRatioToView(self, 1 / 16)
        view1.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.titleL, 0).heightRatioToView(self, 5 / 16)
        view2.sd_layout().leftEqualToView(self).rightEqualToView(self).topSpaceToView(self.view1, 0).heightRatioToView(self, 5 / 16)
        view3.sd_layout().leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightRatioToView(self, 5 / 16)
        
        
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
