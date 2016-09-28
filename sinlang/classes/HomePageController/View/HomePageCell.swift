//
//  HomePageCell.swift
//  weibolx
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


class HomePageCell: UITableViewCell {

    var iconView = UIImageView()
    var nameB = UIButton.init(type: .Custom)
    var timeL = UILabel()
    var textL = UILabel()
    var myView = UIView()
    var repostBtn = CommentBtn.init(type: .Custom)
    var commentBtn = CommentBtn.init(type: .Custom)
    var attitudeBtn = CommentBtn.init(type: .Custom)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.contentView.sd_layout().spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0))
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.addSubview(iconView)
        self.addSubview(nameB)
        self.addSubview(timeL)
        self.addSubview(textL)
        self.addSubview(myView)
        self.addSubview(repostBtn)
        self.addSubview(commentBtn)
        self.addSubview(attitudeBtn)
        
        nameB.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        nameB.setTitleColor(UIColor.blueColor(), forState: .Normal)
        nameB.contentHorizontalAlignment = .Left
        
        timeL.font = UIFont.systemFontOfSize(12)
        timeL.textColor = UIColor.grayColor()
        
        textL.font = UIFont.boldSystemFontOfSize(18)
        textL.textColor = UIColor.blackColor()
        textL.numberOfLines = 0
        
        repostBtn.setImage(UIImage.init(named: "timeline_icon_retweet"), forState: .Normal)
        commentBtn.setImage(UIImage.init(named: "timeline_icon_comment"), forState: .Normal)
        attitudeBtn.setImage(UIImage.init(named: "timeline_icon_unlike"), forState: .Normal)
        
        iconView.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self, aSpace).widthIs(50).heightIs(50)
        nameB.sd_layout().leftSpaceToView(self.iconView, aSpace).topSpaceToView(self,aSpace).heightIs(30).rightEqualToView(self)
        timeL.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self.nameB, 0).heightIs(20).rightEqualToView(self)
        
        repostBtn.sd_layout().leftSpaceToView(self, aSpace).bottomSpaceToView(self,0).heightIs(40).widthRatioToView(self, 1/3)
        commentBtn.sd_layout().bottomSpaceToView(self, 0).heightIs(40).widthRatioToView(self,1/3).leftSpaceToView(self.repostBtn, 0)
        attitudeBtn.sd_layout().rightSpaceToView(self, aSpace).bottomSpaceToView(self, 0).heightIs(40).widthRatioToView(self, 1/3)
        
        myView.sd_layout().leftSpaceToView(self, aSpace).rightSpaceToView(self, aSpace).bottomSpaceToView(self.repostBtn,bSpace).heightIs(0.1)
        
        textL.sd_layout().leftSpaceToView(self, aSpace).topSpaceToView(self.iconView,bSpace).rightSpaceToView(self, aSpace).bottomSpaceToView(self.myView, bSpace)
        
    }
    
    func removeSubViews() {
        for v in myView.subviews {
            v.removeFromSuperview()
        }
    }
    
    func setupMyView(arr: [String]) {
        let myWidth = SCREEN_W - aSpace * 2
        if arr.count > 0 {
            var i = 0
            if arr.count == 1 {
                let img = UIImageView.init(frame: CGRectMake(aSpace, 0, myWidth / 2 * 1.5, myWidth / 2 * 1.5))
                img.sd_setImageWithURL(NSURL.init(string: arr[0]))
                self.myView.addSubview(img)
            } else if arr.count <= 4 {
                for _ in arr {
                    let img = UIImageView.init(frame: CGRectMake(aSpace + CGFloat(i % 2) * myWidth / 2, CGFloat(i / 2) * myWidth / 2, myWidth / 2 - 3, myWidth / 2 - 3))
                    img.sd_setImageWithURL(NSURL.init(string: arr[i]))
                    self.myView.addSubview(img)
                    i += 1
                }
            } else if arr.count <= 6 {
                for _ in arr {
                    let img = UIImageView.init(frame: CGRectMake(aSpace + CGFloat(i % 3) * myWidth / 3, CGFloat(i / 3) * myWidth / 3, myWidth / 3 - 2, myWidth / 3 - 2))
                    img.sd_setImageWithURL(NSURL.init(string: arr[i]))
                    self.myView.addSubview(img)
                    i += 1
                }
            } else {
                for _ in arr {
                    let img = UIImageView.init(frame: CGRectMake(aSpace + CGFloat(i % 3) * myWidth / 3, CGFloat(i / 3) * myWidth / 3, myWidth / 3 - 2, myWidth / 3 - 2))
                    img.sd_setImageWithURL(NSURL.init(string: arr[i]))
                    self.myView.addSubview(img)
                    i += 1
                    if i > 8 {
                        let label = UILabel.init(frame: CGRectMake(30, 50, 80, 30))
                        label.text = "+更多"
                        label.font = UIFont.boldSystemFontOfSize(25)
                        label.textColor = UIColor.blackColor()
                        label.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                        img.addSubview(label)
                        break
                    }
                }
            }
        }
    }
    

}




















