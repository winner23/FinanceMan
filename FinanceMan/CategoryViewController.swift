//
//  CategoryViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBAction func saveCategoryChanges(_ sender: UIButton) {
        
    }
  
    @IBOutlet weak var nameCategory: UITextField!
    
    @IBOutlet weak var descriptionCategory: UITextField!
    
    private let model = CoreModel.coreModel
    private let category = CategoryModel()
    
    override func viewDidLoad() {
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
