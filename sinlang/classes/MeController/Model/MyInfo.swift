//
//  MyInfo.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

var user = MyInfo()

class MyInfo: NSObject {

    var name = ""
    class var shareUser: MyInfo {
        return user
    }
}
