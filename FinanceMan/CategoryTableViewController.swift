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
    
    @objc func openNewView(){
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
        let selectedCategory = model.categories[indexPath.row]
        self.saveAction!(selectedCategory)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        let categoryItem = model.categories[indexPath.row]
        cell.categoryName.text = categoryItem.name
        cell.categoryDescription.text = categoryItem.descriptionContext
        cell.icon.text = categoryItem.icon
        if categoryItem.type {
            cell.categoryName.textColor = UIColor.green
        } else {
            cell.categoryName.textColor = UIColor.blue
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let category = model.categories[indexPath.row].id
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

       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCategory" {
            let tempVC = (segue.destination as? CategoryViewController)!
            let catId = sender as? String
            let categoryInst = model.getCategoryInstance(byId: catId!)!
            
            tempVC.currentCategory = categoryInst
            
        }
        
    }
    

}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
