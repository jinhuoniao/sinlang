//
//  PersonModel.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PersonModel: JSONModel {
    var avatarHd: String!
    var coverImagePhone: String?
    var location: String!
    var screenName: String!
    var gender: String!
    var id: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}


extension PersonModel {
    
    class func requestGetPersonalInfo(uid: String, accessToken: String, callBack:(array: [AnyObject]?, error: NSError?) -> Void) {
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let para = ["uid": uid, "access_token":accessToken]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let ob = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let obj = NSMutableArray()
                obj.addObject(ob)
                var personArr = NSMutableArray()
                do {
                    personArr = try PersonModel.arrayOfModelsFromDictionaries(obj as [AnyObject], error: ())
                } catch {
                    
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: personArr as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
}
