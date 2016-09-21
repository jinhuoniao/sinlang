//
//  FriendsModel.swift
//  weibolx
//
//  Created by qianfeng on 16/9/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FriendsModel: JSONModel {

    var avatarHd: String!
    var name: String!
    var Description: String?
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.avatarHd = dict["avatar_hd"] as! String
        self.name = dict["name"] as! String
        self.Description = dict["description"] as? String
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
