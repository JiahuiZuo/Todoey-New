//
//  AppDelegate.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
//            _ =  try Realm()
            let realm = try Realm()
            
        } catch {
            
            print("Error Initializing New Realm, \(error)")
            
        }
        
        return true
    }


}

