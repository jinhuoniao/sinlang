//
//  LrcModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class LrcModel: NSObject {

    var time: NSTimeInterval!
    var text: String!
    
    func initWithLrcString(lrcString: String) -> LrcModel {
        self.text = lrcString.componentsSeparatedByString("]").last!
        let timeString = lrcString.componentsSeparatedByString("]").first!.substringFromIndex(lrcString.startIndex.successor())
        self.time = self.timeWithString(timeString)
        return self
    }
    
    func timeWithString(timeString: String) -> NSTimeInterval{
        let minute = Int(timeString.componentsSeparatedByString(":").first!)
        let second = Int(timeString.componentsSeparatedByString(":").last!.componentsSeparatedByString(".").first!)
        let millsSecond = Int(timeString.componentsSeparatedByString(":").last!.componentsSeparatedByString(".").last!)
        return Double(minute! * 60 + second!) + Double(millsSecond!)
            * 0.01
    }
    
    class func lrcModelWithLrcString(lrc: String) -> LrcModel{
        let model = LrcModel()
        return model.initWithLrcString(lrc)
    }
    
}


