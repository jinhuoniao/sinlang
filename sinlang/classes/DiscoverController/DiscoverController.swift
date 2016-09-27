//
//  DiscoverController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataList = [PlayerModel]()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 64))
        tableView.registerClass(DiscoverCell.self, forCellReuseIdentifier: "DiscoverCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.view.addSubview(tableView)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.getData()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "直播"
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.getData()
        })
        tableView.mj_header.beginRefreshing()
    }
    
    func getData() {
        let urlStr = "http://service.inke.com/api/live/aggregation?imsi=&uid=147970465&proto=6&idfa=3EDE83E7-9CD1-4186-9F37-EE77B7423265&lc=0000000000000027&cc=TG0001&imei=&sid=20tJHn0JsxdmOGkbNjpEjo3DIKFyoyboTrCjMvP7zNxofi1QNXT&cv=IK3.2.00_Iphone&devi=134a83cdf2e6701fa8f85c099c5e68ac3ea7bd4b&conn=Wifi&ua=iPhone%205s&idfv=5CCB6FE7-1F0F-4288-90DC-946D6F6C45C2&osversion=ios_9.300000&interest=1&location=0"
        let para = ["format":"json"]
        MyNetworkTool.netWorkToolGetWithUrl(urlStr, parameters: para) { (data) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .MutableContainers) as! NSDictionary
            let listArray = obj["lives"] as! NSArray
            for dict in listArray {
                let model = PlayerModel()
                let dic = dict as! [String: AnyObject]
                model.city = dic["city"] as? String
                model.portrait = dic["creator"]!["portrait"] as? String
                model.name = dic["creator"]!["nick"] as! String
                let users = dic["online_users"] as! Int
                model.onlineUsers = "\(users)"
                model.url = dic["stream_addr"] as! String
                self.dataList.append(model)
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverCell", forIndexPath: indexPath) as! DiscoverCell
        let model = dataList[indexPath.row]
        cell.headImage.sd_setImageWithURL(NSURL.init(string: String.init(format: "http://img.meelive.cn/%@", model.portrait!)))
        cell.coverImage.sd_setImageWithURL(NSURL.init(string: String.init(format: "http://img.meelive.cn/%@", model.portrait!)))
        cell.nameL.text = model.name
        cell.numL.text = String.init(format: "%@人在看", model.onlineUsers!)
        if model.city == nil {
            
        } else {
            cell.addressL.text = model.city!
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let playVC = PlayerController()
        let model = self.dataList[indexPath.row]
        playVC.liveUrl = model.url
        playVC.imageUrl = model.portrait!
        playVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(playVC, animated: true)
        //self.prefersStatusBarHidden()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
}






























