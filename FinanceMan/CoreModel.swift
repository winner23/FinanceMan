//
//  CoreModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/11/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation
class CoreModel {
    
    var categories = [CategoryModel]()
    var transactions = [TransactionModel]()
    
    func addCategory(id: UInt, name: String){
        let newCategory = CategoryModel(ID: id, CategoryName: name)
        categories.append(newCategory)
    }
    
    func addTransaction(id: UInt, name: String, category: CategoryModel){
        let newTransaction = TransactionModel(
    }
}
