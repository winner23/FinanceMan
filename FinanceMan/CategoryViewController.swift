//
//  CategoryViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    let model = CoreModel.coreModel
    
    var currentCategory: CategoryModel?
    //private let category = CategoryModel()
    
    @IBOutlet weak var nameCategory: UITextField!
    @IBOutlet weak var iconCollection: UICollectionView!
    @IBOutlet weak var descriptionCategory: UITextField!
    @IBOutlet weak var typeCategory: UISwitch!
    @IBAction func saveCategoryChanges(_ sender: RCButton) {
        
        let name = nameCategory.text ?? "NoName"
        let descr = descriptionCategory.text ?? "No Description"
        let type = typeCategory.isOn
        let icon = 
        if currentCategory == nil {
            //FIXIT: replace @ for same icon text realization
            model.addCategory(name: name, descrip: descr, type: type, icon: "@")
        } else {
            model.modifyCategory(byId: currentCategory!.getId(), name: name, descriptionText: descr,)
        }
        model.saveCategories()
        self.navigationController?.popViewController(animated: true)
    }
  

    


    
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
