//
//  SearchInfoModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SearchInfoModel: JSONModel {
    var song: NSArray?
    var album: NSArray?
    var artist: NSArray?
    var total: String?
    var songList: NSArray?
    var albumList: NSArray?
    var artistList: NSArray?
    var songInfo: SearchInfoModel?
    var artistInfo: SearchInfoModel?
    var albumInfo: SearchInfoModel?
}
