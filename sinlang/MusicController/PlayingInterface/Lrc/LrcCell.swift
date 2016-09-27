//
//  LrcCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LrcCell: UITableViewCell {

    let lrcL = LrcLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(lrcL)
        lrcL.textColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        lrcL.font = UIFont.systemFontOfSize(15)
        lrcL.textAlignment = .Center
        lrcL.translatesAutoresizingMaskIntoConstraints = false
        lrcL.sd_layout().centerXEqualToView(self).centerYEqualToView(self).heightIs(30).widthIs(400)
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
