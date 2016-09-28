//
//  SearchReferralView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SearchReferralView: UITableViewController, UISearchBarDelegate {

    var search = UISearchBar()
    var song = NSMutableArray()
    var album = NSMutableArray()
    var artlist = NSMutableArray()
    var text = ""
    
    func setSearchText(text: String) {
        self.text = text
        self.loadSearchData(text)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.search.text = self.text
        self.search.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
    }
    
    func setupSearchBar() {
        self.search = UISearchBar.init(frame: CGRectMake(0, 0, SCREEN_W - 100, 44))
        self.search.delegate = self
        self.search.searchBarStyle = .Prominent
        self.search.tintColor = UIColor.greenColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.titleView = self.search
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.song.count > 5 ? 5 : self.song.count
        } else if section == 1 {
            return self.album.count > 5 ? 5 : self.album.count
        } else {
            return self.artlist.count > 5 ? 5 : self.artlist.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "referralCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell.init(style: .Value1, reuseIdentifier: ID)
        }
        cell?.textLabel?.font = UIFont.systemFontOfSize(20)
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(15)
        if self.song.count > 0 && indexPath.section == 0 {
            let songList = self.song[indexPath.row]
            if songList.songname != nil {
                cell?.textLabel?.text = songList.songname
            }
            if songList.artisname == nil {
                //cell?.detailTextLabel?.text = songList.artisname
            }
        } else if self.album.count > 0 && indexPath.section == 1 {
            let album = self.album[indexPath.row]
            if album.albumname != nil {
                //cell?.textLabel?.text = album.albumname
            }
            if album.artisname == nil {
                cell?.detailTextLabel?.text = album.artisname
            }
        }
        else if self.artlist.count > 0 && indexPath.section == 2 {
            let artist = self.artlist[indexPath.row]
            if artist.artisname == nil {
                //cell?.textLabel?.text = artist.artisname
            }
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = SearchHeadCell.headView(self.tableView)
        if section == 0 {
            head.setHeadTitle("歌曲", button: "")
        } else if section == 1 {
            head.setHeadTitle("专辑", button: "")
        } else {
            head.setHeadTitle("歌手", button: "")
        }
        return head
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return self.song.count > 0 ? 30 : 0
        } else if section == 1 {
            return self.album.count > 0 ? 30 : 0
        } else {
            return self.artlist.count > 0 ? 30 : 0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var text = ""
//        if indexPath.section == 0 {
//            let song = self.song[indexPath.row]
//            text = song.songname
//        } else if indexPath.section == 1 {
//            let album = self.album[indexPath.row]
//            text = album.albumname
//        } else {
//            let artist = self.artlist[indexPath.row]
//            text = artist.artisname
//        }
        self.pushToSearchResultView(text)
    }

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.search.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadSearchData(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.addSearch(searchBar.text!)
        self.pushToSearchResultView(text)
    }
    
    func addSearch(text: String) {
        
    }

    func loadSearchData(text: String) {
        let set = NSCharacterSet.URLFragmentAllowedCharacterSet()
        let key = text.stringByAddingPercentEncodingWithAllowedCharacters(set)!
        let para = NSMutableDictionary.init(dictionary: BasePara)
        para.setObject("baidu.ting.search.catalogSug", forKey: "method")
        para.setObject(key, forKey: "query")
        
        MyNetworkTool.netWorkToolGetWithUrl(TingUrl, parameters: para) { (data) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .MutableContainers) as! NSDictionary
            let info = HCSearchInfoModel.mj_objectWithKeyValues(obj)
            if info.song != nil {
                let arrSong = info.song as NSArray
                self.song = arrSong.mutableCopy() as! NSMutableArray
            }
            if info.album != nil {
                let arrAlbum = info.album as NSArray
                self.album = arrAlbum.mutableCopy() as! NSMutableArray
            }
            if info.artist != nil {
                let arrArtlist = info.artist as NSArray
                self.artlist = arrArtlist.mutableCopy() as! NSMutableArray
            }
            self.tableView.reloadData()
        }
    }
    
    func pushToSearchResultView(text: String) {
        let result = SearchResultView()
        result.setSearchText(text)
        self.navigationController?.pushViewController(result, animated: true)
    }
}
























