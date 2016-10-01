//
//  NewModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/30.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class LifeInfoNewModel: JSONModel {
    var chuanyi: NSArray?
    var ganmao: NSArray?
    var kongtiao: NSArray?
    var wuran: NSArray?
    var xiche: NSArray?
    var yundong: NSArray?
    var ziwaixian: NSArray?
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.chuanyi = dict["chuanyi"] as? NSArray
        self.ganmao = dict["ganmao"] as? NSArray
        self.kongtiao = dict["kongtiao"] as? NSArray
        self.wuran = dict["wuran"] as? NSArray
        self.xiche = dict["xiche"] as? NSArray
        self.yundong = dict["yundong"] as? NSArray
        self.ziwaixian = dict["ziwaixian"] as? NSArray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
}

class Pm25NewModel: JSONModel {
    var cityName: String!
    var dateTime: String!
    var curPm: String!
    var quality: String!
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.cityName = dict["cityName"] as! String
        self.dateTime = dict["dateTime"] as! String
        self.curPm = dict["pm25"]!["curPm"] as! String
        self.quality = dict["pm25"]!["quality"] as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
}

class RealtimeNewModel: JSONModel {
    var cityName: String!
    var date: String!
    var moon: String!
    var temperature: String!
    var info: String!
    var direct: String!  //东北风
    var power: String!   //3级
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.cityName = dict["city_name"] as! String
        self.date = dict["date"] as! String
        self.moon = dict["moon"] as! String
        self.temperature = dict["weather"]!["temperature"] as! String
        self.info = dict["weather"]!["info"] as! String
        self.direct = dict["wind"]!["direct"] as! String
        self.power = dict["wind"]!["power"] as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
}

class WeatherNewModel: JSONModel{
    var date: String!
    var nongli: String!
    var week: String!
    var day: NSArray!
    var night: NSArray!
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.date = dict["date"] as! String
        self.nongli = dict["nongli"] as! String
        self.week = dict["week"] as! String
        self.day = dict["info"]!["day"] as! NSArray
        self.night = dict["info"]!["night"] as! NSArray
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WeatherNewModel {
    class func requestWeather(cityName: String, callBack:(lifeInfoArr: [AnyObject]?, pm25Arr: [AnyObject]?, realTimeArr: [AnyObject]?, weatherArr: [AnyObject]?, error: NSError?) -> Void) {
        let set = NSCharacterSet.URLQueryAllowedCharacterSet()
        let city = cityName.stringByAddingPercentEncodingWithAllowedCharacters(set)!
        let url = String.init(format: freeWeatherUrl, city)
        
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                var lifeArr = NSMutableArray()
                var pm25Arr = NSMutableArray()
                var realArr = NSMutableArray()
                var weatherArr = NSMutableArray()
                let life1 = obj["result"]!["life"] as! NSDictionary
                let life = life1["info"] as! NSDictionary
                let pm25 = obj["result"]!["pm25"] as! NSDictionary
                let real = obj["result"]!["realtime"] as! NSDictionary
                let weather = obj["result"]!["weather"] as! [AnyObject]
                do {
                    lifeArr = try LifeInfoNewModel.arrayOfModelsFromDictionaries([life], error: ())
                    pm25Arr = try Pm25NewModel.arrayOfModelsFromDictionaries([pm25], error: ())
                    realArr = try RealtimeNewModel.arrayOfModelsFromDictionaries([real], error: ())
                    weatherArr = try WeatherNewModel.arrayOfModelsFromDictionaries(weather, error: ())
                } catch {
                    
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(lifeInfoArr: lifeArr as [AnyObject], pm25Arr: pm25Arr as [AnyObject], realTimeArr: realArr as [AnyObject], weatherArr: weatherArr as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(lifeInfoArr: nil, pm25Arr: nil, realTimeArr: nil, weatherArr: nil, error: error)
                })
            }
            
        }
    }
}


























