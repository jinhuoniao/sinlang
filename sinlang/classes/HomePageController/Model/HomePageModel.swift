//
//  HomePageModel.swift
//  weibolx
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class HomePageModel: JSONModel {
    
    
    var createdAt: String!
    var attitudesCount: String? //点赞
    var commentsCount: String? //评论
    var repostsCount: String? //转发
    var originalPic: String?
    var bmiddlePic: String?
    var text: String?
    var user: NSDictionary?
    var picUrls: NSArray?
    var id: String?
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
    
    func height(model: HomePageModel) -> CGFloat{
        var height: CGFloat = 0
        let myText = model.text
        if myText != nil {
            let str = myText! as NSString
            let width = UIScreen.mainScreen().bounds.width - CGFloat(2 * aSpace)
            var dic = [String: AnyObject]()
            dic[NSFontAttributeName] = UIFont.boldSystemFontOfSize(18)
            height = str.boundingRectWithSize(CGSizeMake(width, CGFloat(MAXFLOAT)), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: dic, context: nil).size.height
        }
        return height
    }
    
    func imgHeight(model: HomePageModel) -> CGFloat {
        var height: CGFloat = 0
        let arr = model.picUrls
        if arr?.count > 0 {
            if arr?.count == 1 {
                height += (SCREEN_W - bSpace * 2) / 2 * 1.5
            }else if arr?.count == 2 {
                height += (SCREEN_W - bSpace * 2) / 2
            }else if arr?.count <= 4 {
                height += (SCREEN_W - bSpace * 2) 
            } else if arr?.count <= 6 {
                height += (SCREEN_W - bSpace * 2) / 3 * 2
            } else {
                height += (SCREEN_W - bSpace * 2)
            }
        }
        return height + bSpace * 2
    }
}

class UserModel: JSONModel {
    
    var name: String!
    var avatarHd: String? //头像
    var id: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
    
}


extension HomePageModel {
    class func requestHomeData(page: String, callBack:(array: [AnyObject]?, error: NSError?) -> Void) {
        let account = UserInfo.mytoken()
        let para = ["access_token":account[1],"page": page]
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let statuses = obj["statuses"] as! [AnyObject]
                let homeArr = try! HomePageModel.arrayOfModelsFromDictionaries(statuses, error: ())
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: homeArr as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
}

























