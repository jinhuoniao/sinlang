//
//  ScienceController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ScienceController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64), style: .Plain)
        tableView.registerClass(ScienceCell.self, forCellReuseIdentifier: "ScienceCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    var page = 2
    var dataArr = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = true
        self.getData(1, tag: 1)
        self.tableView.mj_header = MJRefreshHeader.init(refreshingBlock: { 
            self.getData(1, tag: 1)
            self.page = 2
        })
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            self.getData(self.page, tag: 2)
            self.page += 1
        })
        self.tableView.mj_header.beginRefreshing()
    }

    
    func getData(page: Int, tag: Int) {
        if tag == 1 {
            ScienceModel.request(1, callBack: { (array, error) in
                self.dataArr.removeAllObjects()
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
            })
        } else {
            ScienceModel.request(page, callBack: { (array, error) in
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScienceCell", forIndexPath: indexPath) as! ScienceCell
        let model = dataArr[indexPath.row] as! ScienceModel
        cell.timeL.text = model.ctime
        cell.descL.text = model.Description
        cell.titleL.text = model.title
        cell.picView.sd_setImageWithURL(NSURL.init(string: model.picUrl))
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let web = WebController()
        let model = self.dataArr[indexPath.row] as! ScienceModel
        web.urlStr = model.url
        self.navigationController?.pushViewController(web, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
