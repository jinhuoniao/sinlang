//
//  CityInfoModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CityInfoModel: JSONModel {
    var area: String!
    var cityId: String!
    var cnName: String!
    var enName: String!
    var province: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    
    
    
    class func requestCityInfo(callBack:()->Void){
        BaseRequest.getWithURL(CityIdUrl, para: nil) { (data, error) in
            if error != nil {
                return
            }
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let arr = obj["result"] as! [AnyObject]
            var array = NSMutableArray()
            do {
                array = try CityInfoModel.arrayOfModelsFromDictionaries(arr, error: ())
            } catch {
                print("error")
            }
            CityInfo.saveCityInfo(array as [AnyObject])
            dispatch_async(dispatch_get_main_queue(), { 
                callBack()
            })
        }
    }
}
