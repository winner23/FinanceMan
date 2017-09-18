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
    
    
    @IBOutlet weak var valueTransaction: UITextField!
    
    @IBOutlet weak var categoryButton: RCButton!
    
    @IBOutlet weak var descriptionTransaction: UITextView!
    
    @IBOutlet weak var dateTransaction: UIDatePicker!
    
    @IBAction func saveTransaction(_ sender: UIButton) {
        let value = valueTransaction.text ?? "0"
        
        let descripTran = descriptionTransaction.text ?? ""
        let date = dateTransaction.date
        let category = categoryButton.currentTitle ?? "No category"
        if let categoryId = model.getCategoryId(byName: category){
            
            model.addTransaction(categoryId: categoryId, volume: value, descriptionText: descripTran, date: date)
            
            model.saveTransactions()
            self.navigationController?.popViewController(animated: true)
        } else {
            showWarningMsg(textMsg: "No such category")
        }
        
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        return allowedCharacters.isSuperset(of: characterSet)
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
//        
//        let components = string.components(separatedBy: inverseSet)
//        
//        let filtered = components.joined(separator: "")
//        
//     
//        
//        if filtered == string {
//            
//            return true
//        } else {
//            if string == "." {
//                
//                let countdots = textField.text!.components(separatedBy:".").count - 1
//                
//                if countdots == 0 {
//                    
//                    
//                    return true
//                }else{
//                    if countdots > 0 && string == "." {
//                        return false
//                    } else {
//                        return true
//                    }
//                }
//            }else{
//                return false
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueTransaction.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
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
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "₴"
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
