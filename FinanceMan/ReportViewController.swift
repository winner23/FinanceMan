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
    
    @IBOutlet weak var ctegorySelector: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    @IBOutlet weak var byCategoryButton: UIButton!
    @IBAction func reportByCategory(_ sender: UIButton) {

        let selectedCategory = model.categories[ctegorySelector.selectedRow(inComponent: 0)]
        //let result = calcTotal(byCategory: selectedCategory)
        let data = prepareArrayForCalculation(byCategory: selectedCategory)
        performSegue(withIdentifier: "byCategory", sender: data)
    }
    
    @IBAction func reportOnDate(_ sender: UIButton) {

    }
    
    @IBAction func reportBetween(_ sender: UIButton) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.categories[row].name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if model.categories.count<1 {
           byCategoryButton.isEnabled = false
        }
    }

    // MARK: Calculations methods
    
    func calcTotal(byCategory selected: CategoryModel) -> Double {
        var counter: NSDecimalNumber = 0.0
        for transaction in model.transactions {
            if selected.id == transaction.categoryId,
            let checkVolume = transaction.volume {
                counter = counter.adding(checkVolume)
            }
        }
        return counter.doubleValue
    }
    
    func prepareArrayForCalculation(byCategory selected: CategoryModel) -> [(date: Date, value: NSDecimalNumber)] {
        var resultArray: [(date: Date, value: NSDecimalNumber)] = []
        for transaction in model.transactions {
            if let date = transaction.date,
                let volume = transaction.volume {
                resultArray.append((date, volume))
            }
        }
        return resultArray
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "byCategory",
            let result = sender as? [(date: Date, value: NSDecimalNumber)],
            let reportResultViewController = (segue.destination) as? ReportResultsViewController {
            reportResultViewController.reportViewByCategory = result
            //reportResultViewController.total = "\(result)"
        }
    }
}
