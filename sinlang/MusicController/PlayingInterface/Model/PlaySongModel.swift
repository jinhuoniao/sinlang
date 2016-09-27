//
//  PlaySongModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class PlaySongModel: JSONModel {
    var songName: String!
    var artistName: String!
    var albumName: String!
    var songPicSmall: String!
    var songPicRadio: String!
    var songLink: String!
    var lrcLink: String!
    var showLink: String!
    var songId: String!
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.songName = dict["songName"] as! String
        self.songLink = dict["songLink"] as! String
        self.artistName = dict["artistName"] as! String
        self.albumName = dict["albumName"] as! String
        self.songPicSmall = dict["songPicSmall"] as! String
        self.songPicRadio = dict["songPicRadio"] as! String
        self.lrcLink = dict["lrcLink"] as! String
        self.showLink = dict["showLink"] as! String
        self.songId = String(dict["songId"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}


extension PlaySongModel {
    class func requestGetPlaySong(songId: String, callBack:(array: [AnyObject]?, error: NSError?) -> Void) {
        let para = ["songIds":songId]
        BaseRequest.postWithURL(MusicUrl, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let dic = obj["data"]!["songList"] as! [AnyObject]
                let arr = try! PlaySongModel.arrayOfModelsFromDictionaries(dic, error: ())
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
