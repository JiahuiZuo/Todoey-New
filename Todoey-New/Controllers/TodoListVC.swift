//
//  ViewController.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/22.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListVC: SwipeTableVC {

    var toDoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()
        }
    }
  
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      tableView.separatorStyle = .none
        
        
    }
   
// Navigation won't appear when viewdidLoad shows, so anything relating to navigation bar propertities occurred in ViewDidLoad will crash the project. So we need add viewWillAppear Methods.
    override func viewWillAppear(_ animated: Bool) {
      
        
//        if let colorHex = selectedCategory?.color {
//
//            title = selectedCategory!.name
//
//            guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exit.")}
//
//            if let navBarColor = UIColor(hexString: colorHex) {
//
////               let navBarColor = FlatWhite()
//
//                navBar.barTintColor = navBarColor
//                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
//                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
//                searchBar.barTintColor = navBarColor
//
//            }
//
//        }
       
                 title = selectedCategory?.name
         guard let colorHex = selectedCategory?.color else {fatalError()}
         updateNavBar(withHexCode: colorHex)
        
    }
    
 
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        updateNavBar(withHexCode: "009193")
        
    }
        
    // MARK: Nav Bar Setup Methods
    
    func updateNavBar(withHexCode colorHexCode: String) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exit.")}
        
        guard let navBarColor = UIColor(hexString: colorHexCode) else {fatalError()}
        
        //               let navBarColor = FlatWhite()
        
        navBar.barTintColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
        searchBar.barTintColor = navBarColor
        
    }
        
        
    

    //MARK: TableView Datatsource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
       
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
         
            // if let color = UIColor.FlatWhite().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toDoItems!.count)) .......
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toDoItems!.count)) {
           
                // Version 1 :CGFloat(indexPath.row / toDoItems!.count) : this won't work because the math in the () is Int / Int, the result will be rounded before it's processed as a CGFloat number. So it is important to cast each Int into CGFloat and then divide them.
                
                
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                
            }
            
            
            
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
    
   
    
    override func updateModel(at indexPath: IndexPath) {
        
         super.updateModel(at: indexPath)
        
        if let itemForDeletion = toDoItems?[indexPath.row] {
            
            do {
                
                try realm.write {
                    
                    realm.delete(itemForDeletion) }
                
            } catch {
                
                print("Error deleting item, \(error)") }
            
        }
        
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


