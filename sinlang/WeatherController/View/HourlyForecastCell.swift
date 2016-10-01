//
//  HourlyForecastCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HourlyForecastCell: UITableViewCell {

    let hourlyL = UILabel.init(frame: CGRectMake(bSpace, 0, 200, 20))
    let scrollView = UIScrollView.init(frame: CGRectMake(0, 20, SCREEN_W, 80))
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.addSubview(hourlyL)
        self.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(SCREEN_W * 2, 45)
        hourlyL.textColor = UIColor.whiteColor()
        hourlyL.font = UIFont.systemFontOfSize(15)
        hourlyL.text = "逐小时预报"
        scrollView.layer.borderColor = UIColor.whiteColor().CGColor
        scrollView.layer.borderWidth = 1
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










