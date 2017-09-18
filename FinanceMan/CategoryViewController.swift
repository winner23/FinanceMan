//
//  CategoryViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    var currentCategory: CategoryModel?
    
    @IBAction func saveCategoryChanges(_ sender: RCButton) {
        
        let name = nameCategory.text ?? "NoName"
        let descr = descriptionCategory.text ?? "No Description"
        
        let model = CoreModel.coreModel
        if currentCategory == nil {
            model.addCategory(name: name, descrip: descr)
        } else {
            model.modifyCategory(byId: currentCategory!.getId(), name: name, descriptionText: descr)
        }
        model.saveCategories()
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBOutlet weak var nameCategory: UITextField!
    
    @IBOutlet weak var descriptionCategory: UITextField!
    
    private let model = CoreModel.coreModel
    private let category = CategoryModel()
    
    override func viewDidLoad() {
        if currentCategory != nil {
            nameCategory.text = currentCategory?.getName()
            descriptionCategory.text = currentCategory?.getDescription()
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
