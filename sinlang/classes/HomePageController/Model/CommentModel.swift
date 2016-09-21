//
//  CommentModel.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CommentModel: JSONModel {
    var createdAt: String!
    var id: String!
    var text: String!
    var name: String!
    var attitudesCount: String!
    var avatarHd: String!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.createdAt = dict["created_at"] as! String
        self.id = String(dict["user"]!["id"] as! NSNumber)
        self.text = dict["text"] as! String
        self.name = dict["user"]!["name"] as! String
        self.attitudesCount = String(dict["status"]!["attitudes_count"])
        self.avatarHd = dict["user"]!["avatar_hd"] as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    func height(model: CommentModel) -> CGFloat{
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
    
}
