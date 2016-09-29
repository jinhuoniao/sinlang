//
//  CommentBtn.swift
//  weibolx
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CommentBtn: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        let imgView = UIImageView.init(frame: CGRect.init(x: self.frame.width / 4, y: self.frame.height / 4, width: self.frame.width / 4, height: self.frame.width / 4))
        let label = UILabel.init(frame: CGRect.init(x: self.frame.width / 2, y: self.frame.height / 4, width: self.frame.width / 2, height: self.frame.width / 4))
        self.imageView?.frame = imgView.frame
        self.titleLabel?.frame = label.frame
        self.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
    }

}
