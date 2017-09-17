//
//  TransactionViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    
    private let model = CoreModel.coreModel
    private let transaction = TransactionModel()
    
    @IBOutlet weak var nameTransaction: UITextField!
    
    @IBOutlet weak var valueTransaction: UITextField!
    
    @IBOutlet weak var categoryButton: RCButton!
    
    @IBOutlet weak var descriptionTransaction: UITextView!
    
    @IBOutlet weak var dateTransaction: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCategory",
        let viewController = segue.destination as? CategoryTableViewController {
            viewController.saveAction = { selectedCategory in
                self.transaction.setCategory(id: selectedCategory.getId())
                self.categoryButton.setTitle(selectedCategory.getName(), for: .normal)
            }
        }
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
