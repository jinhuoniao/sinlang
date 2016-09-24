//
//  MusicLibraryController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MusicLibraryController: UIViewController, MyToolBarDelegate, UIScrollViewDelegate {

    var toolBar: MyToolBar!
    var scrollView = UIScrollView.init(frame: CGRectMake(0, 108, SCREEN_W, SCREEN_H - 108))
    lazy var tableView1: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108))
        tableView.backgroundColor = UIColor.grayColor()
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTool()
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(SCREEN_W * 5, SCREEN_H - 108)
        scrollView.bounces = false
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        tableView1.reloadData()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func createTool() {
        toolBar = MyToolBar.init(frame: CGRectMake(0, 64, SCREEN_W, 44), leftSpace: 10, titleArray: ["推荐","排行","歌手","歌单","分类"])
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
    
    

}


























