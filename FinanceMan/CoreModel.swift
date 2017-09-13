//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CoreModel {
    
    private var categories = [CategoryModel]()
    private var transactions = [TransactionModel]()
    
    func addCategory(id: UInt, name: String){
        let newCategory = CategoryModel(ID: id, CategoryName: name)
        categories.append(newCategory)
    }
    
    func getCategory(name:String) -> CategoryModel?{
        for category:CategoryModel in categories{
            if category.getName() == name {
                return category
            }
        }
        return nil
    }
    
    
    
    func addTransaction(category: CategoryModel, bill: String, date: String){
        let newTransaction = TransactionModel(category: category, bill: bill, date: date)
        transactions.append(newTransaction)
    }
    
    func saveTransactions(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: transactions)
        UserDefaults.standard.set(encodedData, forKey: "transactions")
        
    }
    
    func retrievTranactions(){
        if let data = UserDefaults.standard.data(forKey: "transactions"),
            let transactionList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TransactionModel] {
            transactions = transactionList
        }
    }
    
    func retrievCategories(){
        if let data = UserDefaults.standard.data(forKey: "categories"),
            let categireList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CategoryModel] {
            categories = categireList
        }
    }
    
    
    
    
}
