//
//  SongModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class PublicMusicModel: JSONModel {
    var title: String!
    var songId: String!
    var author: String!
    var albumTitle: String!
    var picSmall: String!
    var num: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}

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
        self.songLink = dict["songLink"] as! String
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

extension PublicMusicModel {
    class func requestGetSong(callBack:(array: [AnyObject]?, error: NSError?) -> Void) {
        let para = NSMutableDictionary.init(dictionary: BasePara)
        para.setValue("baidu.ting.billboard.billList", forKey: "method")
        para.setValue("0", forKey: "offset")
        para.setValue("100", forKey: "size")
        para.setValue("1", forKey: "type")
        BaseRequest.getWithURL(TingUrl, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let list = obj["song_list"] as! [AnyObject]
                var arr = NSMutableArray()
                do {
                    arr = try PublicMusicModel.arrayOfModelsFromDictionaries(list, error: ())
                } catch {
                    
                }
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









