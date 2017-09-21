//
//  ReportViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/22/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ctegorySelector: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    @IBAction func reportByCategory(_ sender: UIButton) {
        
        let selectedCategory = categories[ctegorySelector.selectedRow(inComponent: 0)]
        performSegue(withIdentifier: "byCategory", sender: selectedCategory)
    }
    
    @IBAction func reportOnDate(_ sender: UIButton) {
    }
    
    
    
    @IBAction func reportBetween(_ sender: UIButton) {
        
    }
    
    private let model = CoreModel.coreModel
    private var categories: [CategoryModel] = []
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].getName()
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = model.getListCategories()
        

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "byCategory" {
            var counter: NSDecimalNumber = 0.0
            
            let selectedCategory = sender as? CategoryModel
            
            for transaction in model.getTransactions() {
                if selectedCategory?.getId() == transaction.getCategoryId() {
                    counter = counter.adding(transaction.getVolume()!)
                }
            }
            let reportResultViewController = (segue.destination) as? ReportResultsViewController
            let result = counter.doubleValue
            //reportResultViewController?.total.text = String(result)
        }
    }
    

}
