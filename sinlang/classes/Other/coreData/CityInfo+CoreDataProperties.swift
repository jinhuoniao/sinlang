//
//  CityInfo+CoreDataProperties.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CityInfo {

    @NSManaged var area: String?
    @NSManaged var city_id: String?
    @NSManaged var cn_name: String?
    @NSManaged var en_name: String?
    @NSManaged var province: String?

}
