//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CoreModel {
    
    private var categories: [String:String] = [:]
    
    //private var categories = [CategoryModel]()
    private var transactions = [TransactionModel]()
    
//    func addCategory(id: UInt, name: String){
//        let newCategory = CategoryModel(ID: id, CategoryName: name)
//        categories.append(newCategory)
//    }

    func addCategory(name str:String){
        let id = UUID().uuidString
        categories[id] = str
    }
    
//    func getCategory(name:String) -> CategoryModel?{
//        for category:CategoryModel in categories{
//            if category.getName() == name {
//                return category
//            }
//        }
//        return nil
//    }

    func getCategoryName(byId id: String) -> String {
        return categories[id]!
    }
    
    
    func getCategoryId(byName name: String) -> String? {
        for (key, value) in categories{
            if value == name {
                return key
            }
        }
        return nil
    }
    
    func addTransaction(categoryId: String, bill: String, date: String){
        let newTransaction = TransactionModel(categoryId: categoryId, bill: bill, date: date)
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
    
    func saveCategories(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: categories)
        UserDefaults.standard.set(encodedData, forKey: "categories")
        
    }

    func retrievCategories(){
        if let data = UserDefaults.standard.data(forKey: "categories"),
        let categireList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:String] {
            categories = categireList
        }
    }
    
    func getTransactionsBy(categoryName: String) -> [TransactionModel] {
        var res: [TransactionModel] = []
        for transactionInstance:TransactionModel in transactions {
            if getCategoryName(byId: transactionInstance.getCategoryId()) == categoryName {
                res.append(transactionInstance)
            }
        }
        return res
    }
    
    
    
}
