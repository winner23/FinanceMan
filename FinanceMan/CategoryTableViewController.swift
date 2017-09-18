//
//  CategoryTableViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController{

    @IBOutlet var categoryTable: UITableView!
    
    private let model = CoreModel.coreModel
    
    
    var saveAction:((CategoryModel) -> ())?
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationItem = self.navigationItem
        navigationItem.title = "Categories"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.openNewView));
        
        
        navigationItem.rightBarButtonItem = doneItem;
        model.retrievCategories()
        categoryTable.reloadData()
        super.viewWillAppear(animated)
    }
    
    func openNewView(){
        self.performSegue(withIdentifier: "newCategory", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //Select category
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = model.getListCategories()
        let selectedCategory = categories[indexPath.row]
        self.saveAction!(selectedCategory)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.getListCategories().count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        
        cell.categoryName.text = model.getListCategories()[indexPath.row].getName()
        cell.categoryDescription.text = model.getListCategories()[indexPath.row].getDescription()

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let category = model.getListCategories()[indexPath.row].getId()
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
            self.performSegue(withIdentifier: "editCategory", sender: category)
        }
        let delete = UITableViewRowAction(style: .destructive, title: "Del") { action, index in
            self.model.deleteCategory(byId: category)
            self.categoryTable.beginUpdates()
            self.categoryTable.deleteRows(at: [indexPath], with: .automatic)
            self.categoryTable.endUpdates()
            
        }
        return [edit, delete]
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "editCategory" {
            let tempVC = (segue.destination as? CategoryViewController)!
            let catId = sender as? String
            let categoryInst = model.getCategoryInstance(byId: catId!)!
            
            tempVC.currentCategory = categoryInst
            
        }
        
    }
    

}