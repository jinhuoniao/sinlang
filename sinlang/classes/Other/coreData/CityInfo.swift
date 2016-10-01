//
//  CityInfo.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import CoreData


class CityInfo: NSManagedObject {
    
    class func coordinator() -> NSPersistentStoreCoordinator{
        let path = NSBundle.mainBundle().pathForResource("weibo", ofType: "momd")!
        let model = NSManagedObjectModel.init(contentsOfURL: NSURL.init(fileURLWithPath: path))!
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
        let sqlPath = NSHomeDirectory() + "/Documents/cityInfo.sqlite"
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL.init(fileURLWithPath: sqlPath), options: nil)
        return coordinator
    }


    class func saveCityInfo(models: [AnyObject]) {
        
        do {
            for m in models {
                let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
                context.persistentStoreCoordinator = self.coordinator()
                let saveModel = NSEntityDescription.insertNewObjectForEntityForName("CityInfo", inManagedObjectContext: context) as! CityInfo
                let model = m as! CityInfoModel
                saveModel.area = model.area
                saveModel.city_id = model.cityId
                saveModel.cn_name = model.cnName
                saveModel.en_name = model.enName
                saveModel.province = model.province
                try context.save()
            }
        } catch {
            print("城市信息存储失败")
        }
    }
    
    class func cityInfoSaved() -> Bool {
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "CityInfo")
        var dataArr = [CityInfo]()
        do {
            dataArr = try context.executeFetchRequest(request) as! [CityInfo]
            if dataArr.count > 500 {
                return true
            }
            
        } catch {
            print("城市信息未存储")
        }
        return false
    }
    
    class func getCityID(enName: String) -> String {
        var arr = [CityInfo]()
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "CityInfo")
        let predicate = NSPredicate.init(format: "en_name like %@", enName)
        request.predicate = predicate
        do {
            arr = try context.executeFetchRequest(request) as! [CityInfo]
        } catch {
            print("查询城市ID失败")
        }
        if arr.count == 0 {
            return "111"
        }
        let cityId = arr[0].city_id!
        return cityId
    }
    
    class func getAllID() {
        var arr = [CityInfo]()
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "CityInfo")
        do {
            arr = try context.executeFetchRequest(request) as! [CityInfo]
        } catch {
            print("查询城市ID失败")
        }
        for a in arr {
            print(a.cn_name!)
        }
    }
    

}


































