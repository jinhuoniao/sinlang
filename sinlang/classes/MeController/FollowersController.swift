//
//  FollowersController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FollowersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var acceToken = ""
    var uid = ""
    var dataArr = NSMutableArray()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H), style: .Plain)
        tableView.registerClass(FriendsCell.self, forCellReuseIdentifier: "FriendsCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.getData()
    }
    
    func getData() {
        let urlStr = "https://api.weibo.com/2/friendships/followers.json"
        let para = ["access_token":acceToken,"uid":uid,"count": "50"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let arr = obj["users"] as! [AnyObject]
            var array = NSMutableArray()
            do {
                array = try FriendsModel.arrayOfModelsFromDictionaries(arr, error: ())
            } catch {
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.dataArr.addObjectsFromArray(array as [AnyObject])
                self.tableView.reloadData()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:tableView协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsCell", forIndexPath: indexPath) as! FriendsCell
        let model = dataArr[indexPath.row] as! FriendsModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.avatarHd))
        cell.nameB.setTitle(model.name, forState: .Normal)
        if model.Description != nil {
            cell.textL.text = model.Description!
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
