//
//  LrcView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LrcView: UIScrollView, UITableViewDataSource, UITableViewDelegate {

//    lazy var currentTime: NSTimeInterval = {
//        let currentTime = NSTimeInterval()
//        return currentTime
//    }()
    lazy var lrcArr: NSArray = {
        var lrc = NSArray()
        self.tableView.reloadData()
        return lrc
    }()
    
    var currentTime: NSTimeInterval = 0
    
    
    var arr = NSArray()
    var tableView = UITableView()
    var currentIndex = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTableView()
        //self.setContont()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTableView() {
        self.addSubview(tableView)
        tableView.backgroundColor = UIColor.redColor()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        self.tableView.rowHeight = 35
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(LrcCell.self, forCellReuseIdentifier: "LrcCell")
        self.tableView.sd_layout().leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self)
    }
    
    func setContont(currentTime: NSTimeInterval) {
        let count = self.lrcArr.count
        for i in 0..<count {
            let lrcLine = self.lrcArr[i] as! LrcModel
            let nextIndex = i + 1
            if nextIndex > count - 1 {
                return
            }
            let nextLrcLine = self.lrcArr[nextIndex] as! LrcModel
            if currentTime >= lrcLine.time && currentTime < nextLrcLine.time && self.currentIndex != i {
                var indexs = [NSIndexPath]()
                if self.currentIndex < count - 1 {
                    let previousIndex = NSIndexPath.init(forRow: self.currentIndex, inSection: 0)
                    indexs.append(previousIndex)
                }
                self.currentIndex = i
                let indexP = NSIndexPath.init(forRow: i, inSection: 0)
                indexs.append(indexP)
                self.tableView.reloadRowsAtIndexPaths(indexs, withRowAnimation: .None)
                self.tableView.scrollToRowAtIndexPath(indexP, atScrollPosition: .Middle, animated: true)
                
            }
            if self.currentIndex == i {
                let indexP = NSIndexPath.init(forRow: i, inSection: 0)
                let cell = self.tableView.cellForRowAtIndexPath(indexP) as? LrcCell
                if cell != nil {
                    cell!.lrcL.progress = CGFloat(self.currentTime - lrcLine.time) / CGFloat(nextLrcLine.time - lrcLine.time)
                    cell!.lrcL.setNeedsDisplay()
                }
                
            }
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lrcArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LrcCell", forIndexPath: indexPath) as! LrcCell
        if indexPath.row == Int(self.currentIndex) {
            cell.lrcL.font = UIFont.systemFontOfSize(20)
        } else {
            cell.lrcL.font = UIFont.systemFontOfSize(15)
            cell.lrcL.progress = 0
        }
        let model = self.lrcArr[indexPath.row] as! LrcModel
        cell.lrcL.text = model.text
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
}

































