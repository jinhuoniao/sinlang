//
//  MeController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var headImage :UIImageView! = nil
    var  nickL:UILabel! = nil
    let account = UserInfo.mytoken()
    lazy var tableView:UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        
        table.showsVerticalScrollIndicator = false
        table.bounces = false
        table.tableHeaderView = self.headerView
        table.delegate = self
        table.dataSource = self
        
        
        return table
    }()
    
    lazy var headerView:UIView = {
        
        let header = HeaderView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 150))
        MyUserModel.requestInfo(self.account[1], uId: self.account[0], callBack: { (dict, error) in
            if error == nil {
                header.headImage.sd_setImageWithURL(NSURL.init(string: dict!["profile_image_url"] as! String))
                header.nameL.text = dict!["screen_name"] as? String
                header.descripeL.text = dict!["description"] as? String
                header.weiboBtn.explainLabel.text = "微博"
                header.weiboBtn.numLabel.text = String(dict!["statuses_count"]!)
                header.weiboBtn.addTarget(self, action: #selector(self.weiboBtnClick), forControlEvents: .TouchUpInside)
                header.careBtn.explainLabel.text = "关注"
                header.careBtn.addTarget(self, action: #selector(self.friendsBtnClick), forControlEvents: .TouchUpInside)
                header.careBtn.numLabel.text = String(dict!["friends_count"]!)
                header.fansBtn.explainLabel.text = "粉丝"
                header.fansBtn.numLabel.text = String(dict!["followers_count"]!)
                header.fansBtn.addTarget(self, action: #selector(self.followersBtnClick), forControlEvents: .TouchUpInside)
            }
        })
        return header
    }()
    
    lazy var dataArray: NSMutableArray = {
        
        let path = NSBundle.mainBundle().pathForResource("Mine", ofType: "plist")
        let array = NSMutableArray.init(contentsOfFile: path!)
        
        return array!
        
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "我"
        self.view.addSubview(self.tableView)
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        self.tableView.tableHeaderView = self.headerView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Edit, target: self, action: #selector(self.settingClick))
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    //MARK: ---  button点击事件
    func settingClick() {
        let setVC = SettingViewController()
        setVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(setVC, animated: true)
    }
    
    func settingBtnClicked(button:UIButton)->Void
    {
        let loginVC = LoginViewController.init()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func friendsBtnClick() {
        let friendController = FriendsController()
        friendController.hidesBottomBarWhenPushed = true
        friendController.uid = self.account[0]
        friendController.acceToken = self.account[1]
        self.navigationController?.pushViewController(friendController, animated: true)
    }
    
    func followersBtnClick() {
        let follow = FollowersController()
        follow.hidesBottomBarWhenPushed = true
        follow.uid = self.account[0]
        follow.acceToken = self.account[1]
        self.navigationController?.pushViewController(follow, animated: true)
    }
    
    func weiboBtnClick() {
        let weibo = MyWeiboController()
        weibo.hidesBottomBarWhenPushed = true
        weibo.uid = self.account[0]
        weibo.acceToken = self.account[1]
        self.navigationController?.pushViewController(weibo, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableView协议方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array = self.dataArray.objectAtIndex(section) as! NSArray
        
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "Identify"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil
        {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: cellId)
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let array = self.dataArray.objectAtIndex(indexPath.section) as! NSArray
        cell?.textLabel?.text = array.objectAtIndex(indexPath.row) as? String
        
        
        if indexPath.section == 2 && indexPath.row == 0
        {
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
            
            cell?.detailTextLabel?.text = "时元夺保时捷718"
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(10)
            
        }
        if indexPath.section == 2 && indexPath.row == 1
        {
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
            
            cell?.detailTextLabel?.text = "每天10000步，你达标了吗？"
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(10)
            
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    //组头视图的高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 9
    }
    //组尾视图的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  view = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 5))
        view.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return view
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let  view = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 1))
        view.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        return view
    }
    
    
    
    
    
}