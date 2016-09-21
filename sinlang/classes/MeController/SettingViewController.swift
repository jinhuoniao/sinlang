//
//  SettingViewController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var headImage :UIImageView! = nil
    var  nickL:UILabel! = nil
    let account = UserInfo.mytoken()
    lazy var tableView:UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        
        table.showsVerticalScrollIndicator = false
        table.bounces = false
        table.delegate = self
        table.dataSource = self
        
        
        return table
    }()
    
    lazy var dataArray: NSMutableArray = {
        
        let path = NSBundle.mainBundle().pathForResource("Setting", ofType: "plist")
        let array = NSMutableArray.init(contentsOfFile: path!)
        
        return array!
        
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
    }
    
    //MARK: ---  button点击事件
    func settingClick() {
        
    }
    
    func settingBtnClicked(button:UIButton)->Void
    {
        let loginVC = LoginViewController.init()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
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
        
        
        
        if indexPath.section == 3 && indexPath.row == 0
        {
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
            
            cell?.detailTextLabel?.text = "4.6M"
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 4 && indexPath.row == 0 {
            UserInfo.exitCurrentLogin()
            exit(0)
        }
    }
    
    
    
    
    
}