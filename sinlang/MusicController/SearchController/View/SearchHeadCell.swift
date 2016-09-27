//
//  SearchHeadCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol SearchHeadCellDelegate: NSObjectProtocol {
    func clickHeadCellBtn()
}

class SearchHeadCell: UITableViewHeaderFooterView {

    weak var delegate: SearchHeadCellDelegate?
    var clickBtn = UIButton.init(type: .Custom)
    var titleLabel = UILabel()
    var isButton: Bool = false
    
    func setHeadTitle(title: String, button: String) {
        titleLabel.text = title
        if button.characters.count > 0 {
            self.clickBtn.setTitle(button, forState: .Normal)
        } else {
            self.clickBtn.hidden = true
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(titleLabel)
        self.titleLabel.frame = CGRectMake(bSpace, 3, SCREEN_W - 100, 20)
        self.titleLabel.font = UIFont.boldSystemFontOfSize(15)
        self.titleLabel.textColor = UIColor.blueColor()
        self.addSubview(clickBtn)
        self.clickBtn.frame = CGRectMake(SCREEN_W - 74, 3, 54, 20)
        self.clickBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        self.clickBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.clickBtn.layer.borderWidth = 1
        self.clickBtn.layer.cornerRadius = 5.0
        self.clickBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.clickBtn.addTarget(self, action: #selector(self.headBtnClick), forControlEvents: .TouchUpInside)
    }
    
    class func headView(tableView: UITableView) -> SearchHeadCell {
        var head = tableView.dequeueReusableHeaderFooterViewWithIdentifier("head") as? SearchHeadCell
        if head == nil {
            head = SearchHeadCell.init(reuseIdentifier: "head")
        }
        return head!
    }
    
    func headBtnClick() {
        self.delegate?.clickHeadCellBtn()
    }
}



























