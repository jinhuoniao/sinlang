//
//  MyPromptTool.swift
//  weibolx
//
//  Created by qianfeng on 16/9/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyPromptTool: NSObject {
    class func promptModeText(text: String, afterDelay time: Double) {
        self.promptMode(.Text, text: text, time: time)
    }
    class func primptModeIndeterminatetext(text: String) -> MBProgressHUD{
        return self.promptMode(.Indeterminate, text: text, time: 0)
    }
    class func promptMode(mode: MBProgressHUDMode, text: String, time: Double) -> MBProgressHUD {
        let view = UIApplication.sharedApplication().delegate?.window
        let prompt = MBProgressHUD.showHUDAddedTo(view!, animated: true)
        prompt.userInteractionEnabled = false
        prompt.mode = mode
        prompt.labelFont = UIFont.systemFontOfSize(15)
        prompt.labelText = text
        prompt.margin = 10
        prompt.removeFromSuperViewOnHide = true
        prompt.hide(true, afterDelay: time)
        return prompt
    }
}
