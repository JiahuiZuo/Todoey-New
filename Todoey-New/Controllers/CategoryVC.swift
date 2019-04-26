//
//  CategoryVC.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/24.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryVC: UITableViewController {

    let realm = try! Realm()
    var categoryArray : Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
        
    }

    //MARK: - TableView Datasource Methods
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categoryArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
        
    }
    
    //MARK: Data Manipulation Methods
    
    // To create/update Realm
    func save(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
        } catch {
           
            print("Error Saving Category, \(error)")
            
        }
        
        tableView.reloadData()
    }
    
  
    // to Read from Realm
    func loadCategories() {
        
       categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()// This will call the tableView Methods again.
    }
    
    
    
    //MARK: Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      

     var textField = UITextField()
        
     let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
    
  
        let action = UIAlertAction (title: "Add Category", style: .default) { (action) in
// What will happen after the "Add Category" is clicked
        

        let newCategory = Category()
        newCategory.name = textField.text!
        self.save(category: newCategory)
        
        }
        
         alert.addAction(action)
        

 // This is adding a text Field Area.
        alert.addTextField { (alertTextField) in

          alertTextField.placeholder = "Create New Category"

            textField = alertTextField

        }
        
        present(alert, animated: true, completion: nil)
        
    }
 
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let desitinationVC = segue.destination as! TodoListVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
        desitinationVC.selectedCategory = categoryArray?[indexPath.row]
            
            
        }
        
        
    }

}
