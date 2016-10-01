//
//  LifeCell.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LifeCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var dataArr = NSMutableArray()
    let lifeArr = ["穿衣指数","感冒指数","空调指数","洗车指数","运动指数","紫外线指数"]
    var numArr = [String]()
    var desArr = [String]()
    init(style: UITableViewCellStyle, reuseIdentifier: String?, dataArr: NSMutableArray) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.selectionStyle = .None
        self.dataArr = dataArr
        let model = self.dataArr[0] as! LifeInfoNewModel
        numArr.append(model.chuanyi![0] as! String)
        numArr.append(model.ganmao![0] as! String)
        numArr.append(model.kongtiao![0] as! String)
        numArr.append(model.xiche![0] as! String)
        numArr.append(model.yundong![0] as! String)
        numArr.append(model.ziwaixian![0] as! String)
        desArr.append(model.chuanyi![1] as! String)
        desArr.append(model.ganmao![1] as! String)
        desArr.append(model.kongtiao![1] as! String)
        desArr.append(model.xiche![1] as! String)
        desArr.append(model.yundong![1] as! String)
        desArr.append(model.ziwaixian![1] as! String)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        
        
        tableView.sd_layout().leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.lifeArr.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 60))
        let L1 = UILabel.init(frame: CGRectMake(80, 15, 200, 30))
        let L2 = UILabel.init(frame: CGRectMake(300, 15, 100, 30))
        L1.textColor = UIColor.whiteColor()
        L1.font = UIFont.boldSystemFontOfSize(20)
        L2.textColor = UIColor.whiteColor()
        L2.font = UIFont.systemFontOfSize(20)
        sView.addSubview(L1)
        sView.addSubview(L2)
        L1.text = self.lifeArr[section]
        L2.text = self.numArr[section]
        return sView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("lifeDes")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "lifeDes")
            self.selectionStyle = .None
            cell?.textLabel?.text = self.desArr[indexPath.section]
            cell?.textLabel?.numberOfLines = 3
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    
    

}



























