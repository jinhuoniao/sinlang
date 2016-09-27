//
//  NewSongFirstController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class NewSongFirstController: UIViewController, UIScrollViewDelegate, MyToolBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var toolBar: MyToolBar!
    var scrollView = UIScrollView.init(frame: CGRectMake(0, 108, SCREEN_W, SCREEN_H - 108))
    var CSList = NSMutableArray()
    lazy var tableView1: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108 - 44))
        tableView.backgroundColor = UIColor.grayColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SongListCell.self, forCellReuseIdentifier: "SongListCell")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    var songIdArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新歌首发"
        self.view.backgroundColor = UIColor.grayColor()
        self.createTool()
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(SCREEN_W * 3, SCREEN_H - 108)
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
        let play = PlayingMusicController.sharePlay
        self.presentViewController(play, animated: true, completion: nil)
    }
    
    func getData() {
        PublicMusicModel.requestGetSong { (array, error) in
            self.CSList.addObjectsFromArray(array!)
            for m in self.CSList {
                let model = m as! PublicMusicModel
                self.songIdArray.addObject(model.songId)
            }
            self.tableView1.reloadData()
        }
    }

    
    func createTool() {
        toolBar = MyToolBar.init(frame: CGRectMake(0, 64, SCREEN_W, 44), leftSpace: 10, titleArray: ["华语","欧美","日韩"])
        toolBar.mydelegate = self
        toolBar.selectedIndex(0)
        toolBar.userInteractionEnabled = true
        self.view.addSubview(toolBar)
    }
    
    func didSelectedTitleAtIndex(index: NSInteger) {
        let i = CGFloat(index)
        scrollView.setContentOffset(CGPoint.init(x: SCREEN_W * i, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = NSInteger(scrollView.contentOffset.x / SCREEN_W)
        toolBar.selectedIndex(index)
    }

    // MARK: - tableView协议
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CSList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongListCell", forIndexPath: indexPath) as! SongListCell
        let model = CSList[indexPath.row] as! PublicMusicModel
        cell.songL.text = model.title
        cell.nameL.text = model.author
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let playC = PlayingMusicController.sharePlay
        playC.setSontIdArray(self.songIdArray, currentIndex: indexPath.row)
        
        
        
    }
    
    

}































