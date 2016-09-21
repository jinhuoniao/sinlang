//
//  MyUserModel.swift
//  weibolx
//
//  Created by qianfeng on 16/9/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyUserModel: JSONModel {
    var statusesCount: String!
    var friendsCount: String!
    var followersCount: String!
    var profileImageUrl: String!
    var screenName: String!
    var Description: String!
    
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        super.init()
//        self.Description = dict["description"] as! String
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    required init(data: NSData!) throws {
//        fatalError("init(data:) has not been implemented")
//    }
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}


extension MyUserModel {
    class func requestInfo(accessToken: String, uId: String, callBack:(dict: NSDictionary?, error: NSError?) -> Void) {
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let para = ["access_token":accessToken,"uid":uId]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(dict: obj, error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(dict: nil, error: error)
                })
            }
        }
    }
}