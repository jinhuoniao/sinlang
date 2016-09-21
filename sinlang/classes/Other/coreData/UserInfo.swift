//
//  UserInfo.swift
//  weibolx
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import CoreData


class UserInfo: NSManagedObject {
    
    class func saveMessage(idStr: String, expirStr: String, tokenStr: String) {
        
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "UserInfo")
        var dataArr = [UserInfo]()
        do {
            dataArr = try context.executeFetchRequest(request) as! [UserInfo]
            if dataArr.count > 0 {
                return
            }
            let addModel = NSEntityDescription.insertNewObjectForEntityForName("UserInfo", inManagedObjectContext: context) as! UserInfo
            addModel.uid = idStr
            addModel.expires_in = expirStr
            addModel.access_token = tokenStr
            try context.save()
            
        } catch {
            print("查询失败")
        }
    }
    
    class func coordinator() -> NSPersistentStoreCoordinator{
        let path = NSBundle.mainBundle().pathForResource("weibo", ofType: "momd")!
        let model = NSManagedObjectModel.init(contentsOfURL: NSURL.init(fileURLWithPath: path))!
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
        let sqlPath = NSHomeDirectory() + "/Documents/weibo.sqlite"
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL.init(fileURLWithPath: sqlPath), options: nil)
        return coordinator
    }
    
    class func myLogin() -> Bool {
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "UserInfo")
        var dataArr = [UserInfo]()
        do {
            dataArr = try context.executeFetchRequest(request) as! [UserInfo]
            if dataArr.count > 0 {
                return true
            }
        } catch {
            print("查询失败")
        }
        return false
    }
    
    class func mytoken() -> [String] {
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "UserInfo")
        var dataArr = [UserInfo]()
        var arr = [String]()
        do {
            dataArr = try context.executeFetchRequest(request) as! [UserInfo]
            let dicData = dataArr.first!
            arr.append(dicData.uid!)
            arr.append(dicData.access_token!)
        } catch {
            print("查询失败")
        }
        return arr
    }
    
    class func exitCurrentLogin() {
        let context = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator()
        let request = NSFetchRequest.init(entityName: "UserInfo")
        var dataArr = [UserInfo]()
        do {
            dataArr = try context.executeFetchRequest(request) as! [UserInfo]
            if dataArr.count <= 0 {
                return
            }
            let deleteModel = dataArr[0]
            context.deleteObject(deleteModel)
            try context.save()
            
        } catch {
            print("删除失败")
        }

    }
    
}


