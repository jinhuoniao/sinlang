//
//  recommendModels.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
class TopicModel: JSONModel {
    var bannerhd: String!
    var id: String!
    var url: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}

class SongModel: JSONModel {
    var filename: String!
    var singername: String!
    var songname: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}

class AlbumModel: JSONModel {
    var albumid: String!
    var albumname: String!
    var singername: String!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    override class func propertyIsOptional(propertyName: String) -> Bool {
        return true
    }
}

extension TopicModel {
    class func requestRecommend(callBack: (topicArr: [String]?, songArr: [String]?, albumArr: [String]?, error: NSError?) -> Void) {
        let recommentUrl = "http://service.mobile.kugou.com/v1/yueku/recommend?plat=0&type=7&operator=3&version=8281"
        BaseRequest.getWithURL(recommentUrl, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let album = obj["data"]!["info"]!!["album"] as! [AnyObject]
                let topic = obj["data"]!["info"]!!["topic"] as! [AnyObject]
                let song = obj["data"]!["info"]!!["song"] as! [AnyObject]
                var albumArr = NSMutableArray()
                var topicArr = NSMutableArray()
                var songArr = NSMutableArray()
                do {
                    albumArr = try AlbumModel.arrayOfModelsFromDictionaries(album, error: ())
                    topicArr = try TopicModel.arrayOfModelsFromDictionaries(topic, error: ())
                    songArr = try SongModel.arrayOfModelsFromDictionaries(song, error: ())
                } catch {
                    
                }
                
                var imgUrl = [String]()
                for t in topicArr {
                    let m = t as! TopicModel
                    let img = m.bannerhd
                    imgUrl.append(img)
                }
                
                var songname = [String]()
                for s in songArr {
                    let s1 = s as! SongModel
                    let name = s1.filename
                    songname.append(name)
                }
                
                var albumname = [String]()
                for a in albumArr {
                    let a1 = a as! AlbumModel
                    let name2 = a1.albumname
                    let name1 = a1.singername
                    let name = "\(name1)-\(name2)"
                    albumname.append(name)
                }
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(topicArr: imgUrl, songArr: songname, albumArr: albumname, error: nil)
                })
            } else {
                callBack(topicArr: nil, songArr: nil, albumArr: nil, error: error)
            }
        }
    }
}
