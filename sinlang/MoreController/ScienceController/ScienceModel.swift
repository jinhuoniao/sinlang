//
//  ScienceModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ScienceModel: JSONModel {

    var ctime: String!
    var Description: String!
    var title: String!
    var picUrl: String!
    var url: String!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.ctime = dict["ctime"] as! String
        self.Description = dict["description"] as! String
        self.title = dict["title"] as! String
        self.picUrl = dict["picUrl"] as! String
        self.url = dict["url"] as! String
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScienceModel {
    class func request(page: Int, callBack:(array: [AnyObject]?, error: NSError?)->Void) {
        let url = String.init(format: scienceUrl, page)
        BaseRequest.postWithURL(url, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let arr = obj["result"] as! [AnyObject]
                let array = try! ScienceModel.arrayOfModelsFromDictionaries(arr, error: ())
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: array as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil, error: error)
                })
            }
            
        }
    }
}













