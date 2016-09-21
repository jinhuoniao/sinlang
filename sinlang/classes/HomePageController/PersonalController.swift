//
//  PersonalController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PersonalController: UIViewController {

    var uid = 1
    var accessToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlStr = "https://api.weibo.com/2/statuses/user_timeline.json"
        let para = ["access_token":accessToken, "uid":"\(uid)"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            let str = String.init(data: data!, encoding: NSUTF8StringEncoding)!
            print(str)
        }
    }

}
