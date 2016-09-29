//
//  WriteController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WriteController: UIViewController {

    var cancelBtn = UIButton.init(type: .Custom)
    var sendBtn = UIButton.init(type: .Custom)
    var titleL = UILabel()
    var nameL = UILabel()
    var uView = UIView()
    var bView = UIView()
    var textV = UITextView()
    
    var titleStr = ""
    var textPlace = ""
    var weiboId: String?
    let account = UserInfo.mytoken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        self.view.addSubview(uView)
        self.uView.addSubview(cancelBtn)
        self.uView.addSubview(sendBtn)
        self.uView.addSubview(titleL)
        self.uView.addSubview(nameL)
        self.view.addSubview(textV)
        self.view.addSubview(bView)
        
        cancelBtn.layer.borderColor = UIColor.grayColor().CGColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), forControlEvents: .TouchUpInside)
        cancelBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        cancelBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        sendBtn.layer.borderColor = UIColor.grayColor().CGColor
        sendBtn.layer.borderWidth = 1
        sendBtn.setTitle("发送", forState: .Normal)
        sendBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        sendBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        sendBtn.addTarget(self, action: #selector(self.sendBtnClick), forControlEvents: .TouchUpInside)
        titleL.font = UIFont.boldSystemFontOfSize(20)
        titleL.textColor = UIColor.blackColor()
        titleL.textAlignment = .Center
        titleL.text = titleStr
        nameL.font = UIFont.systemFontOfSize(18)
        nameL.textColor = UIColor.grayColor()
        nameL.textAlignment = .Center
        nameL.text = MyInfo.shareUser.name
        
        textV.font = UIFont.boldSystemFontOfSize(20)
        textV.text = textPlace
        
        
        uView.sd_layout().leftEqualToView(self.view).topSpaceToView(self.view, 20).rightEqualToView(self.view).heightIs(44)
        cancelBtn.sd_layout().leftSpaceToView(self.uView, aSpace).topSpaceToView(self.uView, aSpace).bottomSpaceToView(self.uView, aSpace).widthIs(60)
        sendBtn.sd_layout().rightSpaceToView(self.uView, aSpace).topSpaceToView(self.uView,aSpace).bottomSpaceToView(self.uView, aSpace).widthIs(60)
        titleL.sd_layout().topSpaceToView(self.uView, 2).centerXEqualToView(self.uView).widthIs(100).heightIs(20)
        nameL.sd_layout().bottomSpaceToView(self.uView, 2).centerXEqualToView(self.uView).widthIs(300).heightIs(19)
        textV.sd_layout().topSpaceToView(self.uView, bSpace).bottomSpaceToView(self.bView, bSpace * 4).leftEqualToView(self.view).rightEqualToView(self.view)
        bView.sd_layout().leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(44)
        
    }
    
    func cancelBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendBtnClick() {
        //写评论URLFragmentAllowedCharacterSet
        //NSCharacterSet(charactersInString: "!*'\"();:@&=+$,/?%#[]% ").invertedSet
        let set = NSCharacterSet.URLQueryAllowedCharacterSet()
        let comment = textV.text.stringByAddingPercentEncodingWithAllowedCharacters(set)!
        if self.weiboId != nil {
            let urlStr = "https://api.weibo.com/2/comments/create.json"
            let para = ["access_token":account[1], "comment": comment, "id": self.weiboId!]
            BaseRequest.postWithURL(urlStr, para: para, callBack: { (data, error) in
                let str = String.init(data: data!, encoding: NSUTF8StringEncoding)!
                print(str)
            })
        }
    }

}


























