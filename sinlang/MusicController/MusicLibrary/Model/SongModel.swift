//
//  SongModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class PublicMusicModel: JSONModel {
    var title: String!
    var songId: String!
    var author: String!
    var albumTitle: String!
    var picSmall: String!
    var num: String!
    var fileDuration: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}



extension PublicMusicModel {
    class func requestGetSong(callBack:(array: [AnyObject]?, error: NSError?) -> Void) {
        let para = NSMutableDictionary.init(dictionary: BasePara)
        para.setValue("baidu.ting.billboard.billList", forKey: "method")
        para.setValue("0", forKey: "offset")
        para.setValue("100", forKey: "size")
        para.setValue("1", forKey: "type")
        BaseRequest.getWithURL(TingUrl, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let list = obj["song_list"] as! [AnyObject]
                var arr = NSMutableArray()
                do {
                    arr = try PublicMusicModel.arrayOfModelsFromDictionaries(list, error: ())
                } catch {
                    
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: arr as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
            
        }
    }
}











