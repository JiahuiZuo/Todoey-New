//
//  ViewController.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggs", "Destory Earth"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
  

        
    }
    

    // TableView Datatsource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        
        return cell
        
    }
    
    // TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
//      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }

        
    }
    
    
}

