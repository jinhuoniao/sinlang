//
//  SearchController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate, SearchHeadCellDelegate {

    var search = UISearchBar()
    var historyArray = NSArray()
    var hotSearchArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.setupSearchBar()
        self.tableView.separatorStyle = .None
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadHotSearchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupSearchBar() {
        self.search = UISearchBar.init(frame: CGRectMake(0, 0, SCREEN_W - 100, 44))
        self.search.searchBarStyle = .Prominent
        self.search.tintColor = UIColor.redColor()
        self.search.placeholder = "请输入要查找的歌曲"
        self.search.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.titleView = self.search
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.pushToSearchRefferalView(searchText)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = SearchHeadCell.headView(tableView)
        if section == 0 {
            head.setHeadTitle("热门搜索", button: "")
        } else {
            head.setHeadTitle("搜索记录", button: "清空")
        }
        return head
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.historyArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = JCTagListView.init(frame: CGRectMake(0, 0, SCREEN_W, 150))
            cell.tagCornerRadius = 5.0
            cell.canSelectTags = false
            cell.backgroundColor = UIColor.greenColor()
            cell.tags.addObjectsFromArray(self.hotSearchArray as [AnyObject])
            cell.setCompletionBlockWithSelected({ (index) in
                self.pushToSearchResultView(self.hotSearchArray[index] as! String)
            })
            return cell
        } else {
            let ID = "searchCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(ID)
            if cell == nil {
                cell = UITableViewCell.init(style: .Default, reuseIdentifier: ID)
            }
            cell?.imageView?.image = UIImage.init(named: "cm2_list_icn_recent")
            cell?.textLabel?.text = self.historyArray[indexPath.row] as? String
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.pushToSearchResultView(self.historyArray[indexPath.row] as! String)
    }
    
    
    
    func loadHotSearchData() {
        let para = NSMutableDictionary.init(dictionary: BasePara)
        para.setObject("baidu.ting.search.hot", forKey: "method")
        para.setObject("15", forKey: "page_num")
        BaseRequest.getWithURL(TingUrl, para: para) { (data, error) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let arr = obj["result"] as! [AnyObject]
            for d in arr {
                let dict = d as! NSDictionary
                self.hotSearchArray.addObject(dict["word"]!)
            }
            self.tableView.reloadData()
        }
    }
    
    
    func clickHeadCellBtn() {
        let alert = UIAlertController.init(title: "清除所有记录", message: "", preferredStyle: .Alert)
        let cancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        let delete = UIAlertAction.init(title: "确认", style: .Default) { (action) in
            self.deleSearchHistory()
            self.historyArray = []
            self.tableView.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func deleSearchHistory() {
        
    }
    
    func pushToSearchResultView(text: String) {
        
    }
    
    func pushToSearchRefferalView(text: String) {
        
    }
}






























