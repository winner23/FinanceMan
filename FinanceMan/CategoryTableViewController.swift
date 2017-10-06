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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationItem = self.navigationItem
        navigationItem.title = "Categories"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.showScreenForNewCategory));
        navigationItem.rightBarButtonItem = doneItem;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.retrievCategories()
        categoryTable.reloadData()
    }
    
    @objc func showScreenForNewCategory(){
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
        guard let returnCategory = saveAction else {return}
        returnCategory(selectedCategory)
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
        if categoryItem.type == .income {
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
            let categoryViewController = (segue.destination as? CategoryViewController)!
            guard let selectedCategoryId: String = sender as? String else {return}
            if let selectedCategoryInstance = model.getCategoryInstance(byId: selectedCategoryId) {
                categoryViewController.currentCategory = selectedCategoryInstance
            }
        }
    }
}

