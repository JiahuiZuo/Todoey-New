//
//  Category.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/25.
//  Copyright © 2019 TCMR. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
   
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}


