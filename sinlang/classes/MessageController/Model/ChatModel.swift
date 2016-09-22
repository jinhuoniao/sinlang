//
//  ChatModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

enum MessageType: Int {
    case MessageTypeSendToOthers
    case MessageTypeSendToMe
}

class ChatModel: NSObject {

    var messageType = MessageType.MessageTypeSendToOthers
    var iconName: String?
    var text: String?
    var imageName: String?
}
