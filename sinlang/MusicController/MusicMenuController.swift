//
//  MusicMenuController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


class MusicMenuController: UIViewController, NavTitleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var titleView: NavTitleView!
    lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let contentView = UICollectionView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 39), collectionViewLayout:layout)
        contentView.contentOffset = CGPointMake(0, 0)
        contentView.pagingEnabled = true
        contentView.backgroundColor = UIColor.grayColor()
        contentView.showsHorizontalScrollIndicator = false
        contentView.registerClass(HearController.self, forCellWithReuseIdentifier: "HearController")
        contentView.registerClass(WatchController.self, forCellWithReuseIdentifier: "WatchController")
        contentView.registerClass(SingController.self, forCellWithReuseIdentifier: "SingController")
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "goback"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.backClick))
        self.automaticallyAdjustsScrollViewInsets = false
        self.contentView.reloadData()
        self.createTitleView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.listenUp), name: "pushToMusicLibrary", object: nil)
    }
    
    func listenUp() -> Void {
        let musicLibraryC = MusicLibraryController()
        self.navigationController?.pushViewController(musicLibraryC, animated: true)
    }
    
    func backClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func createTitleView() {
        titleView = NavTitleView.init(frame: CGRectMake(80, 20, SCREEN_W - 160, 44), leftSpace: 80, titleArray: ["听","看","唱"])
        titleView.delegate = self
        titleView.selectedIndex(0)
        self.navigationItem.titleView = titleView
    }

    //MARK: titleview的协议方法
    func didSelectedTitleAtIndex(index: NSInteger) {
        //设置collectionView的偏移量
        
        self.contentView.setContentOffset(CGPointMake(CGFloat(index) * SCREEN_W, 0), animated: true)
    }
    
    // MARK: - 协议方法
    
    //返回三个页面
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellID = ""
        if indexPath.item == 0 {
            cellID = "HearController"
        } else if indexPath.item == 1 {
            cellID = "WatchController"
        } else {
            cellID = "SingController"
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(SCREEN_W, SCREEN_H - 64 - 49)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = NSInteger(scrollView.contentOffset.x / SCREEN_W)
        titleView.selectedIndex(index)
    }

}






















