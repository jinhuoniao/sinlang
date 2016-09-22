//
//  PersonalController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//  3921755237

import UIKit

class PersonalController: UIViewController {

    var uid = 1
    var accessToken = ""
    var dataArr = NSMutableArray()
    var name = ""
    lazy var headView: UIView = {
        let myView = PersonalHeadView.init(frame: CGRectMake(0, 64, SCREEN_W, 200))
        PersonModel.requestGetPersonalInfo("\(self.uid)", accessToken: self.accessToken, callBack: { (array, error) in
            if error == nil {
                self.dataArr.addObjectsFromArray(array!)
                let model = self.dataArr[0] as! PersonModel
                if model.coverImagePhone != nil {
                    myView.coverImageL.sd_setImageWithURL(NSURL.init(string: model.coverImagePhone!))
                }
                myView.iconImage.sd_setImageWithURL((NSURL.init(string: model.avatarHd)))
                myView.screenNameL.text = model.screenName
                self.name = model.screenName
                let sex = model.gender
                var str = "未知"
                if sex == "f" {
                    str = "女"
                } else if sex == "m" {
                    str = "男"
                }
                myView.genderL.text = str
                myView.localtionL.text = model.location
                myView.chatBtn.tag = Int(model.id)!
                myView.chatBtn.addTarget(self, action: #selector(self.chatBtnClick(_:)), forControlEvents: .TouchUpInside)
            }
        })
        return myView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.view.addSubview(headView)
    }
    
    func chatBtnClick(button: UIButton) {
        let chatVC = ChatViewController()
        chatVC.navigationItem.hidesBackButton = true
        chatVC.name = self.name
        chatVC.toId = self.uid
        chatVC.accessToken = self.accessToken
        self.navigationController?.pushViewController(chatVC, animated: true)
    }

}
