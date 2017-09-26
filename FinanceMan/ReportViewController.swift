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
    private let report = ReportModel()
    
    
    @IBOutlet weak var ctegorySelector: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    @IBOutlet weak var byCategoryButton: UIButton!
    @IBAction func reportByCategory(_ sender: UIButton) {
        let selectedCategory = model.categories[ctegorySelector.selectedRow(inComponent: 0)]
        
        let data = report.prepareArrayForCalculation(byCategory: selectedCategory)
        
        performSegue(withIdentifier: "byCategory", sender: data)
    }
    
    @IBAction func reportOnDate(_ sender: UIButton) {
        // Remove time from Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: fromDate.date)
        let date = dateFormatter.date(from: selectedDate)!
        let data = report.prepareArrayForCalculation(byDate: date)
        performSegue(withIdentifier: "onDate", sender: data)
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

 
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "byCategory"{
            let result = sender as? [(date: Date, value: Double)]
            let reportResultViewController = (segue.destination) as? ReportResultsViewController
            reportResultViewController?.reportViewByCategory = result
            
        }
        if segue.identifier == "onDate",
            let result = sender as? [(categoryName: String, value: Double)],
            let reportResultViewController = (segue.destination) as? ReportResultsViewController {
                reportResultViewController.reportViewByDate = result
        }
    }
}
