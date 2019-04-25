//
//  ViewController.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {

    
//    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Earth"]
    
  var itemArray = [Item]()
   
//    let defaults = UserDefaults.standard
   
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()
        }
    }
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
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
        
       
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
   
        
        
//         print(dataFilePath)
        
//           loadItems()
        
    
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//
//            itemArray = items
//        }

        
    }
    

    //MARK: TableView Datatsource Method
    
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
    
    //MARK: TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
//      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
//        print(itemArray[indexPath.row])
 
        
        
        
 /*
         itemArray.remove(at: indexPath.row) : remove this item from the array including its indexpath after the row is clicked
         context.delete(itemArray[indexPath.row]): remove this item from database using its indexPath.
         
         the order is very important. if you remove from the item array first and then removing from the context will crush because the indexPath got screwed up.
*/
 
        // those two line of code: when the row is clicked, it got removed instead of removing the checkmark.
//     context.delete(itemArray[indexPath.row])
//     itemArray.remove(at: indexPath.row)
//
 
        
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
            
//            let newItem = Item()
//            newItem.title = textField.text!
//            self.itemArray.append(newItem)
//            self.saveItems()
           
//          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory
            
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
        
        
//        let encoder = PropertyListEncoder()
        
        do {
            
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
            
           
           try context.save()
            
            
        } catch {
            
//            print("Error encoding item array, \(error)")
            
            print("Error saving context \(error)")
        }
        
        // if you don't reload the table view, it won't show in the interface.
        self.tableView.reloadData()
        
    }
    
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {

        // = Item.fetchRequest() : add a default value for the parameter, so if you call loadItems() without anything in the parameter, it works.
        
        
        
//        if let data = try? Data(contentsOf: dataFilePath!) {
//
//            let decoder = PropertyListDecoder()
//
//            do {
//
//                itemArray = try decoder.decode([Item].self, from: data)
//
//            } catch {
//
//                print("Error decoding item array, \(error)")
//            }
//        }
        
 //       let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {

            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])

        } else {

            request.predicate = categoryPredicate
        }
        
        
        do {
        
//            try context.fetch(request)
            
            itemArray = try context.fetch(request)
        
        } catch {
        
        print("Error fetching data from context, \(error)")
            
        }
        
        tableView.reloadData()
    }
    
}


//MARK: - Search Bar methods

extension TodoListVC: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
         let request : NSFetchRequest<Item> = Item.fetchRequest()
        
//                print(searchBar.text!)
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//                request.predicate = predicate
        
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
//                let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//                request.sortDescriptors = [sortDescriptor]
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
        
//                do {
//                    itemArray = try context.fetch(request)
//                } catch {
//                    print("Error fetching data from context \(error)")
//                }
        
        loadItems(with: request, predicate: predicate)
        
//        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
                // the keyboard and the cursor in the search bar is dismissed.
            }
           
        }
    }
    
}


