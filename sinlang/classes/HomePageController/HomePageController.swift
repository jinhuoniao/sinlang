//
//  HomePageController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HomePageController: UITableViewController {

    var account = [String]()
    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        account = UserInfo.mytoken()
        self.homeMessage()
        self.tableView.registerClass(HomePageCell.self, forCellReuseIdentifier: "HomePageCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
    }
    
    func unReadMessage() {
        let para = ["uid":account[0],"access_token":account[1]]
        let urlStr = "https://rm.api.weibo.com/2/remind/unread_count.json"
        MyNetworkTool.netWorkToolGetWithUrl(urlStr, parameters: para) { (response) in
            let str = NSString.init(data: response as! NSData, encoding: NSUTF8StringEncoding)
            print(str)
        }
    }
    
    func homeMessage() {
        HomePageModel.requestHomeData { (array, error) in
            if error == nil {
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
            } else {
                print("请求出错")
            }
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
        cell.nameB.tag = (model.user!["id"] as? Int)!
        cell.nameB.addTarget(self, action: #selector(self.nameBtnClick(_:)), forControlEvents: .TouchUpInside)
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.user!["avatar_hd"] as! String))
        cell.textL.text = model.text!
        cell.repostBtn.setTitle(model.repostsCount!, forState: .Normal)
        cell.commentBtn.setTitle(model.commentsCount!, forState: .Normal)
        cell.commentBtn.tag = Int(model.id!)!
        cell.commentBtn.addTarget(self, action: #selector(self.commentBtnClick(_:)), forControlEvents: .TouchUpInside)
        cell.attitudeBtn.setTitle(model.attitudesCount!, forState: .Normal)
//        if model.picUrls != nil {
//            var arr = [String]()
//            for pic in model.picUrls! {
//                let dic = pic as! NSDictionary
//                //arr.append(dic["thumbnail_pic"] as! String)
//                arr.append(model.user!["avatar_hd"] as! String)
//            }
//            let myview = CommentView.init(frame: CGRectMake(0, 0, cell.myView.width, cell.myView.height), arr: arr)
//            myview.backgroundColor = UIColor.greenColor()
//            cell.myView = myview
//            cell.setNeedsDisplay()
//        } else {
//            cell.myView.backgroundColor = UIColor.whiteColor()
//            
//        }
        
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
        commentController.accessToken = account[1]
        commentController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(commentController, animated: true)
    }
    
    func nameBtnClick(button: UIButton) {
        let person = PersonalController()
        person.uid = button.tag
        person.accessToken = account[1]
        person.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(person, animated: true)
    }

}



















