//
//  Item.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/25.
//  Copyright © 2019 TCMR. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
