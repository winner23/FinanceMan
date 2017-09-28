//
//  ReportModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/26/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class ReportModel {
    let model = CoreModel.coreModel
    let reportData: [(categoryId: String, date: Date, value: Double, type: CategoryType)]
    
    init(){
        var result: [(categoryId: String, date: Date, value: Double, type: CategoryType)] = []
        for transaction in model.transactions {
            let category = transaction.categoryId
            guard let date = transaction.date else { continue }
            guard let value = transaction.volume?.doubleValue else {continue }
            guard let type = model.getCategoryInstance(byId: category)?.type else {continue}
            result.append((categoryId: category, date: date, value: value, type: type))
        }
        reportData = result
    }
    
    func prepareArrayForCalculation(byCategory selected: CategoryModel) -> [(date: Date, value: Double)] {
        var resultArray: [(date: Date, value: Double)] = []
        let filteredByCategory = reportData.filter({ $0.categoryId == selected.id })
        for instance in filteredByCategory {
                resultArray.append((instance.date, instance.value))
            }
        return resultArray//.filter( { $0.date < Calendar.current.date(byAdding: .month, value: -1, to: $0.date)! } )
    }
    
    func prepareArrayForCalculation(byDate selected: Date) -> [(categoryName: String, value: Double)] {
        var result: [(categoryName: String, value: Double)] = []
        let filtredByDate = reportData.filter({ $0.date == selected })
        var groupedTransactions = [String : Double]()
        for instance in filtredByDate {
            if groupedTransactions[instance.categoryId] != nil {
                guard let operandAdd = groupedTransactions[instance.categoryId] else { continue }
                groupedTransactions[instance.categoryId] = instance.value + operandAdd
            } else {
                groupedTransactions[instance.categoryId] = instance.value
            }
        }
        for (categoryId, value) in groupedTransactions {
            if let categoryName = model.getCategoryName(byId: categoryId) {
                result.append((categoryName, value))
            }
        }
        return result
    }
    
    func prepareArrayForCalculation(between begin: Date, and end: Date) -> [(categoryName: String, value: Double)] {
        var result: [(categoryName: String, value: Double)] = []
        
        let filtredByDate = reportData.filter({ ($0.date > begin) && ($0.date < end) })
        var groupedTransactions = [String : Double]()
        for instance in filtredByDate {
            if groupedTransactions[instance.categoryId] != nil {
                guard let operandAdd = groupedTransactions[instance.categoryId] else { continue }
                groupedTransactions[instance.categoryId] = instance.value + operandAdd
            } else {
                groupedTransactions[instance.categoryId] = instance.value
            }
        }
        for (categoryId, value) in groupedTransactions {
            if let categoryName = model.getCategoryName(byId: categoryId) {
                result.append((categoryName, value))
            }
        }
        return result
    }
}
