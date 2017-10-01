//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CoreModel {
    static let coreModel = CoreModel()
    
    var categories: [CategoryModel] = []
    var transactions: [TransactionModel] = []
    private let fileManager = FileManager()
    private var pathCategories: String = ""
    private var pathTransactions: String = ""
    
    //Core Model is Singleton
    private init(){
        //Prepare for Archiving data to files
        let documentDirectoryUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentDirectoryUrl = documentDirectoryUrls.first {
            self.pathCategories = documentDirectoryUrl.appendingPathComponent("categories.archive").path
            self.pathTransactions = documentDirectoryUrl.appendingPathComponent("transactions.archive").path
        }
    }
    
    //MARK: Categories
    // ----========== Categories operations ==========----
    func addCategory(name: String, descrip: String, type: CategoryType, icon: String?){
        let newCategory = CategoryModel(categoryName: name, descriptionCategory: descrip, isIncome: type, icon: icon)
        categories.append(newCategory)
    }
    
    func getCategoryInstance(byId id:String) -> CategoryModel?{
        for category:CategoryModel in categories{
            if category.id == id {
                return category
            }
        }
        return nil
    }

    func getCategoryName(byId id: String) -> String? {
        for categoryItem in categories {
            if categoryItem.id == id {
                return categoryItem.name
            }
        }
        return nil
    }
    
    func getCategoryId(byName name: String) -> String? {
        for categoryItem in categories{
            if categoryItem.name == name {
                return categoryItem.id
            }
        }
        return nil
    }
    
    func modifyCategory(byId id: String, name: String, descriptionText: String, type: CategoryType, icon: String?) {
        guard let index = getIndexCategory(byId: id) else {return}
        categories[Int(index)].name = name
        categories[Int(index)].descriptionContext = descriptionText
        if categories[Int(index)].type != type {
            categories[Int(index)].type = type
        }
        if icon != nil {
            categories[Int(index)].icon = icon
        }
    }
    func deleteCategory(byId id: String) {
        if let index = getIndexCategory(byId: id) {
            categories.remove(at: Int(index))
            saveCategories()
        }
    }
    
    private func getIndexCategory(byName name: String) -> UInt? {
        for (index, category) in categories.enumerated() {
            if category.name == name {
                return UInt(index)
            }
        }
        return nil
    }
    
    private func getIndexCategory(byId id: String) -> UInt? {
        for (index, category) in categories.enumerated() {
            if category.id == id {
                return UInt(index)
            }
        }
        return nil
    }
    
    //Check for uniqueness of category name
    func checkCategoryExists(name categoryName: String) -> Bool {
        for category in categories {
            if category.name.lowercased() == categoryName.lowercased() {
                return true
            }
        }
        return false
    }
    
    //NSCoding for Category List
    func saveCategories(){
        let pathCategories = self.pathCategories
        let success = NSKeyedArchiver.archiveRootObject(categories, toFile: pathCategories)
        if !success {
            print("Unable to save array to \(pathCategories)")
        }
    }
    
    func retrievCategories(){
        let pathCategories = self.pathCategories
        if let categoryList = NSKeyedUnarchiver.unarchiveObject(withFile: pathCategories) as? [CategoryModel] {
            categories = categoryList
        }
    }
    
    //MARK:Transaction
    // ----========== Transactions operations ==========----
    
    func addTransaction(categoryId: String, volume: String, descriptionText: String, date: Date){
        let newTransaction = TransactionModel(categoryID: categoryId, volume: volume, descriptionText: descriptionText, date: date)
        transactions.insert(newTransaction, at: 0)//.append(newTransaction)
    }
    
    func getTransactionInstance(byIndex index: Int) -> TransactionModel? {
        if index <= transactions.count {
            return transactions[index]
        } else {
            return nil
        }
    }

    func modifyTransaction(byIndex index: Int, toInstance: TransactionModel) {
        if index <= transactions.count {
            transactions[index] = toInstance
        }
    }
    
    func deleteTransactio(byIndex index: Int) {
        if index <= transactions.count {
            transactions.remove(at: index)
        }
    }
    
    //NSCoding for Transaction List
    func saveTransactions(){
        let pathTransactions = self.pathTransactions
        let success = NSKeyedArchiver.archiveRootObject(transactions, toFile: pathTransactions)
        if !success {
            print("Unable to save array to \(pathTransactions)")
        }
    }
    
    func retrievTranactions(){
        let pathTransactions = self.pathTransactions
        if let transactionList = NSKeyedUnarchiver.unarchiveObject(withFile: pathTransactions) as? [TransactionModel]
            {
            transactions = transactionList
        }
    }
}
