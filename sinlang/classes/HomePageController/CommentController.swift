//
//  CommentController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CommentController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weiboId = 1
    var accessToken = ""
    var dataArr = NSMutableArray()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 104), style: UITableViewStyle.Plain)
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
    
    let bView = UIView()
    var repostBtn = CommentBtn.init(type: .Custom)
    var commentBtn = CommentBtn.init(type: .Custom)
    var attitudeBtn = CommentBtn.init(type: .Custom)
    var page = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.setupViews()
        self.getData(1)
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            self.getData(self.page)
            self.page += 1
        })
    }
    
    func setupViews() {
        self.view.addSubview(bView)
        self.bView.addSubview(repostBtn)
        self.bView.addSubview(commentBtn)
        self.bView.addSubview(attitudeBtn)
        repostBtn.setImage(UIImage.init(named: "timeline_icon_retweet"), forState: .Normal)
        commentBtn.setImage(UIImage.init(named: "timeline_icon_comment"), forState: .Normal)
        commentBtn.addTarget(self, action: #selector(self.commentBtnClick), forControlEvents: .TouchUpInside)
        attitudeBtn.setImage(UIImage.init(named: "timeline_icon_unlike"), forState: .Normal)
        bView.sd_layout().leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(40)
        repostBtn.sd_layout().leftSpaceToView(self.bView, 0).bottomSpaceToView(self.bView,2).heightIs(38).widthRatioToView(self.bView, 1/3)
        commentBtn.sd_layout().bottomSpaceToView(self.bView, 2).heightIs(38).widthRatioToView(self.bView,1/3).leftSpaceToView(self.repostBtn, 0)
        attitudeBtn.sd_layout().rightSpaceToView(self.bView, 0).bottomSpaceToView(self.bView, 2).heightIs(38).widthRatioToView(self.bView, 1/3)
    }
    
    func getData(page: Int) {
        let urlStr = "https://api.weibo.com/2/comments/show.json"
        let para = ["access_token":accessToken,"id":"\(weiboId)", "page": "\(page)"]
        
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error != nil {
                return
            }
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let arr = obj["comments"] as! [AnyObject]
            var array = NSMutableArray()
            do {
                array = try CommentModel.arrayOfModelsFromDictionaries(arr, error: ())
            } catch {
                
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.dataArr.addObjectsFromArray(array as [AnyObject])
                self.tableView.reloadData()
            })
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK : -------tableView协议
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        let model = dataArr[indexPath.row] as! CommentModel
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.avatarHd))
        cell.nameB.setTitle(model.name, forState: .Normal)
        cell.nameB.tag = Int(model.id!)!
        cell.timeL.text = model.createdAt
        cell.textL.text = model.text
        cell.nameB.addTarget(self, action: #selector(self.nameBtnClick(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = dataArr[indexPath.row] as! CommentModel
        let h = model.height(model)
        return 100 + h
    }
    
    func nameBtnClick(button: UIButton) {
        let person = PersonalController()
        person.uid = button.tag
        person.accessToken = self.accessToken
        self.navigationController?.pushViewController(person, animated: true)
    }
    
    func commentBtnClick() {
        let CV = WriteController()
        CV.titleStr = "发评论"
        CV.textPlace = "写评论..."
        CV.weiboId = "\(self.weiboId)"
        self.presentViewController(CV, animated: true, completion: nil)
    }
}


















