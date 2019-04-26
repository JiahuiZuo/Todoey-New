//
//  ViewController.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListVC: UITableViewController {

    var toDoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //MARK: TableView Datatsource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//        cell.textLabel?.text = itemArray[indexPath.row]
       
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
        
    }
    
    //MARK: TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            
            do {
            
                try realm.write {
                    
                 item.done = !item.done
//                    realm.delete(item)
                }
                
            } catch {
                
                print("Error Saving Done Status, \(error)")
    
            }
            
        }
         tableView.reloadData()
         tableView.deselectRow(at: indexPath, animated: true)
        
    }
  
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
           
            if let currentCategory = self.selectedCategory {
                do {
                 
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    
                } catch {
                    print("Error Saving New Items, \(error)")
                }
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
//            print(alertTextField.text)
           
        }
        
        
       alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

    func loadItems() {

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
      
        tableView.reloadData()
    }
    
}


//MARK: - Search Bar methods

extension TodoListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        // update toDoItems with a filter
    toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
     tableView.reloadData()
        
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


