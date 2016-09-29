//
//  WebController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WebController: UIViewController {

    let webView = UIWebView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H))
    var urlStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        let request = NSURLRequest.init(URL: NSURL.init(string: urlStr)!)
        webView.loadRequest(request)
        self.automaticallyAdjustsScrollViewInsets = true
        // Do any additional setup after loading the view.
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
