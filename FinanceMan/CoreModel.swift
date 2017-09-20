//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CoreModel {
    
    
    
    private var categories: [CategoryModel] = []
    private var transactions: [TransactionModel] = []
    private let fileManager = FileManager()

    private let pathCategories: String?
    private let pathTransactions: String?
    
    
    //Core Model is Singleton
    private init(){
        //Prepare for Archiving data to files
        let documentDirectoryUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documentDirectoryUrl = documentDirectoryUrls.first {

            self.pathCategories = documentDirectoryUrl.appendingPathComponent("categories.archive").path
            self.pathTransactions = documentDirectoryUrl.appendingPathComponent("transactions.archive").path
        } else {
            self.pathCategories = nil
            self.pathTransactions = nil
        }
        
    }
    
    static let coreModel = CoreModel()
    
    
    
    //MARK: Categories
    // ----========== Categories operations ==========----
    func addCategory(name: String, descrip: String, type: Bool, icon: String?){
        let newCategory = CategoryModel(categoryName: name, descriptionCategory: descrip, isIncome: type, icon: icon)
        categories.append(newCategory)
    }
    
    func getCategoryInstance(byId id:String) -> CategoryModel?{
        for category:CategoryModel in categories{
            if category.getId() == id {
                return category
            }
        }
        return nil
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
    
    func modifyCategory(byId id: String, name: String, descriptionText: String, type: Bool, icon: String?) {
        let index = getIndexCategory(byId: id)
        categories[Int(index!)].setName(name: name)
        categories[Int(index!)].setDescription(text: descriptionText)
        categories[Int(index!)].switchType()
        if icon != nil {
            categories[Int(index!)].setIcon(icon: icon!)
        }
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
        
        if pathCategories != nil {
            let success = NSKeyedArchiver.archiveRootObject(categories, toFile: pathCategories!)
            if !success {
                print("Unable to save array to \(pathCategories!)")
            } else {
               print("File not found")
            }
        }
        
    }
    
    func retrievCategories(){
        
        if pathCategories != nil,
            let categoryList = NSKeyedUnarchiver.unarchiveObject(withFile: pathCategories!) as? [CategoryModel]
        {
            categories = categoryList
        } else {
            print("File not found")
        }
        
    }
    
    //MARK:Transaction
    // ----========== Transactions operations ==========----
    
    func addTransaction(categoryId: String, volume: String, descriptionText: String, date: Date){
        let newTransaction = TransactionModel(categoryID: categoryId, volume: volume, descriptionText: descriptionText, date: date)
        transactions.append(newTransaction)
    }
    
    func getTransactionInstance(byIndex index: Int) -> TransactionModel? {
        if index <= transactions.count {
            return transactions[index]
        } else {
            print("out of bounds index:\(index) for table size:\(transactions.count)")
            return nil
        }
    }

    func modifyTransaction(byIndex index: Int, toInstance: TransactionModel) {
        if index <= transactions.count {
            transactions[index] = toInstance
        } else {
            print("out of bounds index:\(index) for table size:\(transactions.count)")
        }
        
    }
    
    func deleteTransactio(byIndex index: Int) {
        if index <= transactions.count {
            transactions.remove(at: index)
        }
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
        
        if pathTransactions != nil {
            let success = NSKeyedArchiver.archiveRootObject(transactions, toFile: pathTransactions!)
            if !success {
                print("Unable to save array to \(pathTransactions!)")
            } else {
                print("File not found")
            }
        }
    }
    
    func retrievTranactions(){
        
        if pathTransactions != nil,
            let transactionList = NSKeyedUnarchiver.unarchiveObject(withFile: pathTransactions!) as? [TransactionModel]
            {
            transactions = transactionList
        } else {
            print("File not found")
        }
        
    }
    
 
    
    
    
}
