//
//  UserInfo+CoreDataProperties.swift
//  weibolx
//
//  Created by qianfeng on 16/9/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserInfo {

    @NSManaged var uid: String?
    @NSManaged var expires_in: String?
    @NSManaged var access_token: String?

}


