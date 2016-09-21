//
//  OAuthController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import CoreData

class OAuthController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView.init()
        webView.delegate = self
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        let url = NSURL.init(string: "https://api.weibo.com/oauth2/authorize?client_id=568898243&redirect_uri=http://www.sharesdk.cn")
        let request = NSURLRequest.init(URL: url!)
        webView.loadRequest(request)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    //MARK: webView代理方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL?.absoluteString
        let range = url?.rangeOfString("code=")
        if range?.count != nil {
            let fromIndex = range?.endIndex
            let code = url?.substringFromIndex(fromIndex!)
            self.accessTokenWithCode(code!)
            return false
        }
        return true
    }
    
    func accessTokenWithCode(code: String) {
        let url = "https://api.weibo.com/oauth2/access_token"
        let mgr = AFHTTPRequestOperationManager()
        mgr.responseSerializer.acceptableContentTypes = NSSet.init(objects: "text/plain") as? Set<String>
        mgr.responseSerializer = AFHTTPResponseSerializer()
        let params = ["client_id":"568898243","client_secret":"38a4f8204cc784f81f9f0daaf31e02e3","grant_type":"authorization_code","redirect_uri":"http://www.sharesdk.cn","code":code]
        
        mgr.POST(url, parameters: params, success: { (operation, responseObject) in
            print(responseObject)
            let obj = try! NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: .MutableContainers) as! NSDictionary
            let acce = obj["access_token"] as! String
            let expi = obj["expires_in"]
            let uid = obj["uid"]
            let uidStr = String(uid!)
            let expiStr = String(expi!)
            
            UserInfo.saveMessage(uidStr, expirStr: expiStr, tokenStr: acce)
            
            
            let window = UIApplication.sharedApplication().keyWindow
            window?.switchRootViewController()
            }) { (operation, error) in
                print("error")
        }
    }
    
    let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
}



extension UIWindow {
    func switchRootViewController() {
        self.rootViewController = MyTabBarController()
    }
}

















