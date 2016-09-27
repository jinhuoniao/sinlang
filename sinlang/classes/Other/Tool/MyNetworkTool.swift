//
//  MyNetworkTool.swift
//  weibolx
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyNetworkTool: NSObject {
    class func netWorkToolPostWithUrl(url: String, parameters: NSDictionary, response success:(AnyObject)->Void) {
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status) in
            if status == AFNetworkReachabilityStatus.Unknown || status == .NotReachable {
                MyPromptTool.promptModeText("没有网络了", afterDelay: 2)
            } else {
                let netPrompt = MyPromptTool.primptModeIndeterminatetext("正在加载中")
                let manager = AFHTTPSessionManager()
                manager.responseSerializer = AFHTTPResponseSerializer()
                manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json","text/html","application/javascript","application/x-www-form-urlencoded") as? Set<String>
                
                manager.POST(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
                    if (responseObject != nil) {
                        netPrompt.removeFromSuperview()
                        success(responseObject!)
                    }
                    }, failure: { (task, error) in
                        netPrompt.removeFromSuperview()
                })
                
            }
        }
    }
    
    class func netWorkToolGetWithUrl(url: String, parameters: NSDictionary, response success:(AnyObject) -> Void) {
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status) in
            if status == AFNetworkReachabilityStatus.Unknown || status == .NotReachable {
                MyPromptTool.promptModeText("没有网络了", afterDelay: 2)
            } else {
                let netPrompt = MyPromptTool.primptModeIndeterminatetext("正在加载中")
                let manager = AFHTTPSessionManager()
                manager.responseSerializer = AFHTTPResponseSerializer()
                //manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json","text/html","application/javascript","application/x-www-form-urlencoded","text/plain") as? Set<String>
                manager.GET(url, parameters: parameters, progress: nil, success: { (task, responseObject) in
                    if responseObject != nil {
                        netPrompt.removeFromSuperview()
                        success(responseObject!)
                    }
                    }, failure: { (task, error) in
                        netPrompt.removeFromSuperview()
                        print("error")
                })
            }
        }
    }
    
    class func netWorkToolDownLoad(string: String, targetPath path: NSSearchPathDirectory, DomainMask mask: NSSearchPathDomainMask, callBack:(endPath: NSURL) -> Void) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let manager = AFURLSessionManager.init(sessionConfiguration: configuration)
        let url = NSURL.init(string: string)
        let request = NSURLRequest.init(URL: url!)
        let downloadTask = manager.downloadTaskWithRequest(request, progress: nil, destination: { (targetPath, response) -> NSURL in
            let documentUrl: NSURL = try! NSFileManager.defaultManager().URLForDirectory(path, inDomain: mask, appropriateForURL: nil, create: true)
            return documentUrl.URLByAppendingPathComponent(response.suggestedFilename!)
            }) { (response, endPath, error) in
                if error == nil {
                    callBack(endPath: endPath!)
                }
        }
        downloadTask.resume()
    }
}

























