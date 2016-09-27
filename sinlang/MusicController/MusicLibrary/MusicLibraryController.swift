//
//  MusicLibraryController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MusicLibraryController: UIViewController, MyToolBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {

    let tab = MusicTabBar.shareMusicBar()
    var toolBar: MyToolBar!
    var albumArray = [String]()
    var songArray = [String]()
    var topicArray = [String]()
    var scrollView = UIScrollView.init(frame: CGRectMake(0, 108, SCREEN_W, SCREEN_H - 108))
    lazy var tableView1: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108))
        tableView.backgroundColor = UIColor.grayColor()
        tableView.tableHeaderView = self.headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NewestMusicCell.self, forCellReuseIdentifier: "NewestMusicCell")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //组合轮播视图和 分类按钮两个子视图
    lazy var headerView:UIView = {
        
        let headerView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 280))
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(self.adView)
        return headerView
    }()
    
    lazy var adView:XTADScrollView = {
        let adView = XTADScrollView.init(frame: CGRectMake(0, 0, SCREEN_W, 180))
        //是否启动轮播
        adView.infiniteLoop = true
        //是否显示pageControl
        adView.needPageControl = true
        //pageControl显示的位置
        adView.pageControlPositionType = pageControlPositionTypeMiddle
        return adView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "乐库"
        self.createTool()
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(SCREEN_W * 5, SCREEN_H - 108)
        scrollView.bounces = false
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.getData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.pushToPlayingCon), name: "toPlayMusicController", object: nil)
    }
    
    func pushToPlayingCon() {
        let arr = self.navigationController?.viewControllers
        if arr?.count == 2 {
            let play = PlayingMusicController.sharePlay
            self.presentViewController(play, animated: true, completion: nil)
        }
    }
    
    func createTool() {
        toolBar = MyToolBar.init(frame: CGRectMake(0, 64, SCREEN_W, 44), leftSpace: 10, titleArray: ["推荐","排行","歌手","歌单","分类"])
        toolBar.mydelegate = self
        toolBar.selectedIndex(0)
        toolBar.userInteractionEnabled = true
        self.view.addSubview(toolBar)
    }
    
    func getData() {
        TopicModel.requestRecommend { (topicArr, songArr, albumArr, error) in
            if error == nil {
                self.topicArray = topicArr!
                self.songArray = songArr!
                self.albumArray = albumArr!
                self.tableView1.reloadData()
                self.adView.imageURLArray = topicArr!
            }
        }
    }
    
    func didSelectedTitleAtIndex(index: NSInteger) {
        let i = CGFloat(index)
        scrollView.setContentOffset(CGPoint.init(x: SCREEN_W * i, y: 0), animated: true)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = NSInteger(scrollView.contentOffset.x / SCREEN_W)
        toolBar.selectedIndex(index)
    }
    
    //MARK: tableView协议方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewestMusicCell", forIndexPath: indexPath) as! NewestMusicCell
            cell.iconImage.image = UIImage.init(named: "icon")
            cell.titleL.text = "新歌首发"
            cell.label1.text = self.songArray[0]
            cell.label2.text = self.songArray[1]
            cell.label3.text = self.songArray[2]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("NewestMusicCell", forIndexPath: indexPath) as! NewestMusicCell
            cell.titleL.text = "新碟上架"
            cell.iconImage.image = UIImage.init(named: "icon")
            cell.label1.text = self.albumArray[0]
            cell.label2.text = self.albumArray[1]
            cell.label3.text = self.albumArray[2]
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let newSong = NewSongFirstController()
            self.navigationController?.pushViewController(newSong, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "toPlayMusicController", object: nil)
    }
}


























