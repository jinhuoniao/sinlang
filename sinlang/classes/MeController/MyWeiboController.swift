//
//  MyWeiboController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyWeiboController:  UITableViewController {
    
    var acceToken = ""
    var uid = ""
    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(HomePageCell.self, forCellReuseIdentifier: "HomePageCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.homeMessage()
    }
    
    
    func homeMessage() {
        let urlStr = "https://api.weibo.com/2/statuses/user_timeline.json"
        let para = ["access_token":acceToken, "uid": uid]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let arr = obj["statuses"] as! [AnyObject]
            var array = NSMutableArray()
            do {
                array = try HomePageModel.arrayOfModelsFromDictionaries(arr, error: ())
            } catch {
                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.dataArr.addObjectsFromArray(array as [AnyObject])
                print(self.dataArr.count)
                self.tableView.reloadData()
            })
            
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HomePageCell", forIndexPath: indexPath) as! HomePageCell
        let model = dataArr[indexPath.row] as! HomePageModel
        
        cell.nameB.setTitle(model.user!["name"] as? String, forState: .Normal)
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.user!["avatar_hd"] as! String))
        cell.textL.text = model.text!
        cell.repostBtn.setTitle(model.repostsCount!, forState: .Normal)
        cell.commentBtn.setTitle(model.commentsCount!, forState: .Normal)
        cell.commentBtn.tag = Int(model.id!)!
        cell.commentBtn.addTarget(self, action: #selector(self.commentBtnClick(_:)), forControlEvents: .TouchUpInside)
        cell.attitudeBtn.setTitle(model.attitudesCount!, forState: .Normal)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = dataArr[indexPath.row] as! HomePageModel
        let h = model.height(model)
        return 140 + h
    }
    
    func commentBtnClick(btn: UIButton) {
        let commentController = CommentController()
        commentController.weiboId = btn.tag
        commentController.accessToken = self.acceToken
        commentController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(commentController, animated: true)
    }
    
}
