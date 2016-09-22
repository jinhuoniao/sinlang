//
//  ChatViewController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var fromId = 1
    var toId = 2
    var accessToken = ""
    var name = "haha"
    var bottomView = UIView.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - 40, UIScreen.mainScreen().bounds.width, 40))
    var textTF = UITextField()
    var letfBtn = UIButton.init(type: .Custom)
    let rightBtn = UIButton.init(type: .Custom)
    var dataArr = [ChatModel]()
    var height = 50
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - 100, UIScreen.mainScreen().bounds.width, 100))
        self.view.addSubview(tableView)
        tableView.registerClass(LeftCell.self, forCellReuseIdentifier: "LeftCell")
        tableView.registerClass(RightCell.self, forCellReuseIdentifier: "RightCell")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.reloadData()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.navigationItem.title = name
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Edit, target: self, action: #selector(self.backBtnClick))
        self.createSubviews()
        self.view.sendSubviewToBack(self.tableView)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func createSubviews() {
        self.view.addSubview(bottomView)
        self.bottomView.addSubview(letfBtn)
        self.bottomView.addSubview(textTF)
        self.bottomView.addSubview(rightBtn)
        
        bottomView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        textTF.backgroundColor = UIColor.whiteColor()
        textTF.delegate = self
        
        letfBtn.setTitle("语音", forState: .Normal)
        letfBtn.backgroundColor = UIColor.blueColor()
        letfBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        letfBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        
        rightBtn.setTitle("发送", forState: .Normal)
        rightBtn.backgroundColor = UIColor.blueColor()
        rightBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        rightBtn.addTarget(self, action: #selector(self.sendBtnClick), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        letfBtn.sd_layout().leftSpaceToView(self.bottomView, aSpace).topSpaceToView(self.bottomView, aSpace).bottomSpaceToView(self.bottomView, aSpace).widthIs(40)
        rightBtn.sd_layout().rightSpaceToView(self.bottomView, aSpace).topSpaceToView(self.bottomView,aSpace).bottomSpaceToView(self.bottomView, aSpace).widthIs(40)
        textTF.sd_layout().leftSpaceToView(self.letfBtn, aSpace).topSpaceToView(self.bottomView, aSpace).bottomSpaceToView(self.bottomView, aSpace).rightSpaceToView(self.rightBtn, aSpace)
    }

    
    func backBtnClick() {
        let nav = self.navigationController?.viewControllers[0] as? HomePageController
        if nav != nil {
            let tabCon = nav!.tabBarController as! MyTabBarController
            tabCon.selectedIndex = 1
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func sendBtnClick() {
        let model = ChatModel()
        if self.textTF.text == "" {
            return
        }
        model.text = self.textTF.text
        dataArr.append(model)
        self.tableView.reloadData()
        self.tableView.transform = CGAffineTransformTranslate(self.tableView.transform, 0, -50)
        self.tableView.height += 50
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        if self.bottomView.origin.y > UIScreen.mainScreen().bounds.height - 50 {
            return
        }
        UIView.animateWithDuration(0.25) {
            self.bottomView.origin.y += 280
            self.tableView.bottom = self.bottomView.origin.y
        }
        
    }
    
    //MARK: textField代理方法
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.becomeFirstResponder()
        if self.bottomView.origin.y < UIScreen.mainScreen().bounds.height - 100 {
            return
        }
        UIView.animateWithDuration(0.25) {
            self.bottomView.origin.y -= 280
            self.tableView.bottom = self.bottomView.origin.y
        }
    }

    //MARK:  tableView代理协议
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = dataArr[indexPath.row] 
        if model.messageType == MessageType.MessageTypeSendToOthers{
            let cell = tableView.dequeueReusableCellWithIdentifier("RightCell", forIndexPath: indexPath) as! RightCell
            cell.avator.image = UIImage.init(named: "icon")
            cell.textL.text = model.text
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("LeftCell", forIndexPath: indexPath) as! LeftCell
        cell.textLabel?.text = model.text
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        if self.bottomView.origin.y > UIScreen.mainScreen().bounds.height - 50 {
            return
        }
        UIView.animateWithDuration(0.25) {
            self.bottomView.origin.y += 280
            self.tableView.bottom = self.bottomView.origin.y
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

}





















