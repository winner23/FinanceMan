//
//  TransactionViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/16/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITextFieldDelegate {

    
    private let model = CoreModel.coreModel
    private let transaction = TransactionModel()
    var currentTransaction: TransactionModel?
    var currentTransactionIndex: Int?
    
    @IBOutlet weak var valueTransaction: UITextField!
    
    @IBOutlet weak var categoryButton: RCButton!
    
    @IBOutlet weak var descriptionTransaction: UITextView!
    
    @IBOutlet weak var dateTransaction: UIDatePicker!
    
    @IBAction func saveTransaction(_ sender: UIButton) {
        let value = valueTransaction.text?.replacingOccurrences(of: ",", with: "") ?? "0"
        
        
        let descripTran = descriptionTransaction.text ?? ""
        let date = dateTransaction.date
        let category = categoryButton.currentTitle ?? "No category"
        if let categoryId = model.getCategoryId(byName: category){
            
            if currentTransactionIndex != nil && currentTransaction != nil {
                currentTransaction = TransactionModel(categoryID: categoryId, volume: value, descriptionText: descripTran, date: date)
                model.modifyTransaction(byIndex: currentTransactionIndex!, toInstance: currentTransaction!)
            //
            } else {
                model.addTransaction(categoryId: categoryId, volume: value, descriptionText: descripTran, date: date)
            }
            
            
            model.saveTransactions()
            self.navigationController?.popViewController(animated: true)
        } else {
            showWarningMsg(textMsg: "No such category")
        }
        
    }
    
    override func viewDidLoad() {
        //When edit transaction case
        if currentTransaction != nil {
            let categoryName = model.getCategoryName(byId: (currentTransaction?.getCategoryId())!)
            categoryButton.setTitle(categoryName, for: .normal)
            valueTransaction.text = currentTransaction?.getVolumeString()
            descriptionTransaction.text = currentTransaction?.getDescription()
            dateTransaction.setDate((currentTransaction?.getDate())!, animated: true)
        }
        super.viewDidLoad()
        
        valueTransaction.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
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

    
    // MARK: - Navigation

    private func showWarningMsg(textMsg: String) {
        let alert = UIAlertController(title: "Warning!", message: textMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal//.currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
