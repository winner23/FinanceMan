//
//  ReportViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/22/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let model = CoreModel.coreModel
    private var categories: [CategoryModel] = []
    
    @IBOutlet weak var ctegorySelector: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    @IBAction func reportByCategory(_ sender: UIButton) {
        let selectedCategory = categories[ctegorySelector.selectedRow(inComponent: 0)]
        let result = calc(byCategory: selectedCategory)
        performSegue(withIdentifier: "byCategory", sender: result)
    }
    
    @IBAction func reportOnDate(_ sender: UIButton) {

    }
    
    @IBAction func reportBetween(_ sender: UIButton) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].getName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = model.getListCategories()
    }

    // MARK: Calculations methods
    
    func calc(byCategory selected: CategoryModel) -> Double {
        var counter: NSDecimalNumber = 0.0
        for transaction in model.getTransactions() {
            if selected.getId() == transaction.getCategoryId() {
                counter = counter.adding(transaction.getVolume()!)
            }
        }
        return counter.doubleValue
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "byCategory", let result = sender as? Double, let reportResultViewController = (segue.destination) as? ReportResultsViewController {
            reportResultViewController.total = "\(result)"
        }
    }
    

}
