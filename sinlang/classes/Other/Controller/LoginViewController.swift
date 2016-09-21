//
//  LoginViewController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let imgView = UIImageView()
    let nameTF = UITextField()
    let passTF = UITextField()
    let loginBtn = UIButton()
    let loginUrl = "http://api.weibo.cn/2/account/login?"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 0.9)
        self.setupView()
    }
    
    func setupView() {
        self.view.addSubview(imgView)
        self.view.addSubview(nameTF)
        self.view.addSubview(passTF)
        self.view.addSubview(loginBtn)
        
        imgView.image = UIImage.init(named: "icon")
        
        
        nameTF.borderStyle = .Line
        nameTF.placeholder = "手机号／邮箱"
        nameTF.font = UIFont.systemFontOfSize(20)
        nameTF.leftView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
        nameTF.leftViewMode = .Always
        nameTF.keyboardType = .EmailAddress
        nameTF.returnKeyType = .Next
        
        passTF.borderStyle = .Bezel
        passTF.placeholder = "请输入密码"
        passTF.font = UIFont.systemFontOfSize(20)
        passTF.leftView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
        passTF.leftViewMode = .Always
        passTF.rightView = UIImageView.init(image: UIImage.init(named: "avatar_default"))
        passTF.rightViewMode = .UnlessEditing
        passTF.clearsOnBeginEditing = true
        passTF.returnKeyType = .Done
        
        loginBtn.setTitle("登录", forState: .Normal)
        loginBtn.backgroundColor = UIColor.orangeColor()
        loginBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(30)
        loginBtn.addTarget(self, action: #selector(self.loginClick), forControlEvents: .TouchUpInside)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        self.imgView.sd_layout().widthIs(120).heightIs(120).topSpaceToView(self.view, 80).centerXEqualToView(self.view)
        self.nameTF.sd_layout().leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.imgView, 30).heightIs(60)
        self.passTF.sd_layout().leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.nameTF, 0).heightIs(60)
        self.loginBtn.sd_layout().leftSpaceToView(self.view, 30).rightSpaceToView(self.view, 30).topSpaceToView(self.passTF,30).heightIs(60)
    }
    
    func loginClick() {
        self.view.endEditing(true)
        
        let para = ["u":nameTF.text!,"p":passTF.text!]
        MyNetworkTool.netWorkToolPostWithUrl(loginUrl, parameters: para) { (data) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .AllowFragments) as! NSDictionary
            print(obj)
            let errno = obj["errno"] as? String
            let errmsg = obj["errmsg"] as? String
            print(errno)
            if errno != nil {
                print(errno!)
                if errno! == "-200" {
                    let alertCon = UIAlertController.init(title: "登录失败", message: errmsg!, preferredStyle: .Alert)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(alertCon, animated: false, completion: nil)
                        alertCon.performSelector(#selector(UIAlertController.dismissViewControllerAnimated(_:completion:)), withObject: nil, afterDelay: 1)
                    })
                }
            }

        }
    }
    //"j%2FwaBjY6BZiu8J7072OVLCE68u8SsCAT1cA4eH5rXTqJvP58jH8Q2nWK1z1TmJhbDxlN%2B%2BH%2BeOJa5MBlWNpsbcieqzFNNMtMejwAVd%2BGeHPsCv7SZ6B%2F%2BWmwMMAub5imaRK8ZrR16%2B%2BgX14dFysoKT8XXkfmfvvrMqCzh6obHFs%3D&u=18617007706"
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}



















