//
//  ViewController.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {

//    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Earth"]
    
  var itemArray = [Item]()
   
//    let defaults = UserDefaults.standard
   
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggs"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destory Earth"
//        itemArray.append(newItem3)
        
         print(dataFilePath)
         loadItems()
    
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//
//            itemArray = items
//        }

        
    }
    

    // TableView Datatsource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//        cell.textLabel?.text = itemArray[indexPath.row]
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
//        cell.textLabel?.text = itemArray[indexPath.row].title
  
  
// Ternary operator ==>
       // value = condition ? valueIfTrue : valueIfFalse
        
//        cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//
//            cell.accessoryType = .checkmark
//
//        } else {
//
//            cell.accessoryType = .none
//        }
//
        
//        if itemArray[indexPath.row].done == true {
//
//            cell.accessoryType = .checkmark
//
//        } else {
//
//             cell.accessoryType = .none
//        }
      
        
        
        return cell
        
    }
    
    // TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
//      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
//        print(itemArray[indexPath.row])
        
  
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
//        if  itemArray[indexPath.row].done == false {
//
//            itemArray[indexPath.row].done = true
//
//        } else {
//
//            itemArray[indexPath.row].done = false
//
//        }
        
            
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//             tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//        }

         saveItems()
        
//         tableView.reloadData()
         tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
//            print("success!")
//            print("Add item pressed!")
//            print(textField.text)
            
//            self.itemArray.append(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
           
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
//            let encoder = PropertyListEncoder()
//
//            do {
//
//                let data = try encoder.encode(self.itemArray)
//
//                try data.write(to: self.dataFilePath!)
//
//            } catch {
//
//                print("Error encoding item array, \(error)")
//
//            }
//
//  // if you don't reload the table view, it won't show in the interface.
//            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
//            print(alertTextField.text)
           
        }
        
        
       alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveItems() {
        
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
            
        } catch {
            
            print("Error encoding item array, \(error)")
            
        }
        
        // if you don't reload the table view, it won't show in the interface.
        self.tableView.reloadData()
    }
    
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
           
                itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
                
                print("Error decoding item array, \(error)")
            }
        }
    }
}

