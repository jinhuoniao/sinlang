//
//  DiscoverController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let account = UserInfo.mytoken()
        let para = ["access_token":account[1]]
        let urlStr = "https://api.weibo.com/2/statuses/public_timeline.json"
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            let str = String.init(data: data!, encoding: NSUTF8StringEncoding)
            print(str!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
