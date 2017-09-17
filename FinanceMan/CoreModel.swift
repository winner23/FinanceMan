//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CoreModel {
    
    //private var categories: [String:String] = [:]
    
    private var categories: [CategoryModel] = []
    private var transactions: [TransactionModel] = []
    
    //Core Model is Singleton
    private init(){
        
    }
    
    static let coreModel = CoreModel()
    
    //MARK: Categories
    // ----========== Categories operations ==========----
    func addCategory(name: String, descrip: String){
        let newCategory = CategoryModel(categoryName: name, descriptionCategory: descrip)
        categories.append(newCategory)
    }
    
    
    func getCategoryInstance(byName name:String) -> CategoryModel?{
        for category:CategoryModel in categories{
            if category.getName() == name {
                return category
            }
        }
        return nil
    }

    func getCategoryName(byId id: String) -> String? {
        
        for categoryItem in categories {
            if categoryItem.getId() == id {
                return categoryItem.getName()
            }
        }
        return nil
    }
    
    
    func getCategoryId(byName name: String) -> String? {
        for categoryItem in categories{
            if categoryItem.getName() == name {
                return categoryItem.getId()
            }
        }
        return nil
    }
    
    func getListCategories() -> [CategoryModel]{
        return categories
    }
    
    
    func deleteCategory(byId id: String) {
        if let index = getIndexCategory(byId: id) {
            categories.remove(at: Int(index))
        }
    }
    
    private func getIndexCategory(byName name: String) -> UInt? {
        for (index, category) in categories.enumerated() {
            if category.getName() == name {
                return UInt(index)
            }
        }
        return nil
    }
    
    private func getIndexCategory(byId id: String) -> UInt? {
        for (index, category) in categories.enumerated() {
            if category.getId() == id {
                return UInt(index)
            }
        }
        return nil
    }
    
    //NSCoding for Category List
    func saveCategories(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: categories)
        UserDefaults.standard.set(encodedData, forKey: "categories")
        
    }
    
    func retrievCategories(){
        if let data = UserDefaults.standard.data(forKey: "categories"),
            let categireList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CategoryModel] {
            categories = categireList
        }
    }
    
    //MARK:Transaction
    // ----========== Transactions operations ==========----
    
    func addTransaction(categoryId: String, volume: String, date: String){
        let newTransaction = TransactionModel(categoryID: categoryId, volume: volume, date: date)
        transactions.append(newTransaction)
    }
    
    func getTransactions() -> [TransactionModel] {
        return transactions
    }
    
    func getTransactions(categoryName: String) -> [TransactionModel] {
        var res: [TransactionModel] = []
        for transactionInstance:TransactionModel in transactions {
            if getCategoryName(byId: transactionInstance.getCategoryId()) == categoryName {
                res.append(transactionInstance)
            }
        }
        return res
    }
    
    //NSCoding for Transaction List
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
    
 
    
    
    
}
