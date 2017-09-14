//
//  CategoryController.swift
//  FinanceMan
//
//  Created by ITA student on 9/14/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryController:UIViewController, UITableViewDelegate {
    
    private var category:CategoryModel?
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBAction func addCategory(_ sender: RCButton) {
        self.category = CategoryModel(name: categoryTextField.text!)
    }
    
    @IBAction func textChange(_ sender: UITextField) {
        if sender.text!.characters.count > 3 {
            getCategoriesContains(textCategory)
        }
    }
    
    private var textCategory:String{
        get{
            return categoryTextField.text!
        }
        set{
            categoryTextField.text = newValue
        }
    }
}
