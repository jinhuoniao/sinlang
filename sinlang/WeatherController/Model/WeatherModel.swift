//
//  WeatherModel.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class AlarmsModel: JSONModel {
    var level: String?  //预警等级
    var stat: String?   //预警状态
    var title: String?  //预警信息标题
    var txt: String?    //预警信息详情
    var type: String?   //预警天气类型
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
}

class AqiModel: JSONModel {
    var aqi: String?   //空气质量指数
    var qlty: String?  //空气质量等级
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.aqi = dict["aqi"] as? String
        self.qlty = dict["qlty"] as? String
        
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BasicModel: JSONModel {
    var city: String!
    var updateTime: String!  //更新时间
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.city = dict["city"] as! String
        self.updateTime = dict["update"]!["loc"] as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
}

class DailyForecastModel: JSONModel {
//    var sr: String! //日出时间
//    var ss: String! //日落时间
//    var txtD: String! //白天天气状况描述
//    var txtN: String! //夜间天气状况描述
//    var max: String! //最高温度
//    var min: String! //最低温度
//    var sc: String! //风力
    
    var astro: NSDictionary!
    var cond: NSDictionary!
    var tmp: NSDictionary!
    var date: String! //预报日期
    var wind: NSDictionary!
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
//    override class func propertyIsOptional(propertyName: String) -> Bool {
//        return true
//    }
    
    
}

class HourlyForecastModel: JSONModel {
    var date: String!  //时间
    var tmp: String!   //温度
    
    override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class NowModel: JSONModel {
    var txt: String!    //当前天气描述
    var hum: String!   //湿度
    var pres: String!  //气压
    var dir: String!   //风向
    var sc: String!    //风力
    var spd: String!   //风速
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.txt = dict["cond"]!["txt"] as! String
        self.hum = dict["hum"] as! String
        self.pres = dict["pres"] as! String
        self.dir = dict["wind"]!["dir"] as! String
        self.sc = dict["wind"]!["sc"] as! String
        self.spd = dict["wind"]!["spd"] as! String
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
}

class SuggestionModel: JSONModel {
    var comf: NSDictionary! //舒适度指数
    var cw: NSDictionary! //洗车指数
    var drsg: NSDictionary!  //穿衣指数
    var flu: NSDictionary!  //感冒指数
    var sport: NSDictionary! //运动指数
    var trav: NSDictionary! //旅游指数
    var uv: NSDictionary!  //紫外线指数
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.comf = dict["comf"] as! NSDictionary
        self.cw = dict["cw"] as! NSDictionary
        self.drsg = dict["drsg"] as! NSDictionary
        self.flu = dict["flu"] as! NSDictionary
        self.sport = dict["sport"] as! NSDictionary
        self.trav = dict["trav"] as! NSDictionary
        self.uv = dict["uv"] as! NSDictionary
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
}


extension AlarmsModel {
    
    class func requestData(cityName: String, callBack:(alarmsArr: [AnyObject]?, aqiArr: [AnyObject]?, basicArr: [AnyObject]?, dailyForecastArr: [AnyObject]?, hourlyForecastArr: [AnyObject]?, nowArr: [AnyObject]?, suggestionArr: [AnyObject]?, error: NSError?) -> Void) {
        let url = String.init(format: weatherUrl, cityName)
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                let resultDic = obj["result"] as! NSDictionary
                var alarmArr = NSMutableArray()
                var aqiArr = NSMutableArray()
                var basicArr = NSMutableArray()
                var dailyForecastArr = NSMutableArray()
                var hourlyForecastArr = NSMutableArray()
                var nowArr = NSMutableArray()
                var suggestionArr = NSMutableArray()
                
                let alarms = resultDic["alarms"] as! [AnyObject]
                
                let city = resultDic["aqi"]!["city"] as! NSDictionary
//                let modelDict = NSMutableDictionary.init(dictionary: city)
//                let arr = NSArray.init(array: city.allKeys)
//                modelDict.setObject(city["num"]!, forKey: "aqi")
//                modelDict.setObject(city["des"]!, forKey: "qlty")
                let basic = resultDic["basic"] as! NSDictionary
                let dailyForecast = resultDic["daily_forecast"] as! [AnyObject]
                let hourlyForecast = resultDic["hourly_forecast"] as! [AnyObject]
                let now = resultDic["now"] as! NSDictionary
                let suggestion = resultDic["suggestion"] as! NSDictionary
                do {
                    alarmArr = try AlbumModel.arrayOfModelsFromDictionaries(alarms, error: ())
                    aqiArr = try AqiModel.arrayOfModelsFromDictionaries([city], error: ())
                    basicArr = try BasicModel.arrayOfModelsFromDictionaries([basic], error: ())
                    dailyForecastArr = try DailyForecastModel.arrayOfModelsFromDictionaries(dailyForecast, error: ())
                    hourlyForecastArr = try HourlyForecastModel.arrayOfModelsFromDictionaries(hourlyForecast, error: ())
                    nowArr = try NowModel.arrayOfModelsFromDictionaries([now], error: ())
                    suggestionArr = try SuggestionModel.arrayOfModelsFromDictionaries([suggestion], error: ())
                    
                } catch {
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(alarmsArr: alarmArr as [AnyObject], aqiArr: aqiArr as [AnyObject], basicArr: basicArr as [AnyObject], dailyForecastArr: dailyForecastArr as [AnyObject], hourlyForecastArr: hourlyForecastArr as [AnyObject], nowArr: nowArr as [AnyObject], suggestionArr: suggestionArr as [AnyObject], error: nil)
                })
                
                
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(alarmsArr: nil, aqiArr: nil, basicArr: nil, dailyForecastArr: nil, hourlyForecastArr: nil,  nowArr: nil, suggestionArr: nil, error: error)
                })
            }
            
        }
    }
}


























