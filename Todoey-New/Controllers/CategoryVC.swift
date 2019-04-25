//
//  CategoryVC.swift
//  Todoey-New
//
//  Created by Jiahui Zuo on 2019/4/24.
//  Copyright © 2019 TCMR. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    
//    var categoryArray = ["Grocery", "Bills", "Passwords"]
//
    var categoryArray = [Category]()

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
        
        
    }

    //MARK: - TableView Datasource Methods
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
       
        
        return cell
        
    }
    
    

   
    
    //MARK: Data Manipulation Methods
    
    // To create Context
    func saveCategories() {
        
        
        do {
            
            try context.save()
        } catch {
            print("Error Saving Category, \(error)")
            
        }
        
        tableView.reloadData()
    }
    
  
    // to Read from Context
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            
            categoryArray = try context.fetch(request)
            // saving data read from context to categoryArray
            
        } catch {
            
            print("Error Loading Categories, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: Add New Categories
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      

        var textField = UITextField()
        
     let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
    
  
        let action = UIAlertAction (title: "Add Category", style: .default) { (action) in
// What will happen after the "Add Category" is clicked
        
//       print("Success!")
        
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
    
        self.categoryArray.append(newCategory)
            
        self.saveCategories()
            

//        self.categoryArray.append(textField.text!)
        
//        self.tableView.reloadData()

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
            
        desitinationVC.selectedCategory = categoryArray[indexPath.row]
            
            
        }
        
        
    }
    
    
    

}
