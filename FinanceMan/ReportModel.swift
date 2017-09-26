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
    let reportData: [(categoryId: String, date: Date, value: Double)]
    
    init(){
        var result: [(categoryId: String, date: Date, value: Double)] = []
        for transaction in model.transactions {
            let category = transaction.categoryId
            let date = transaction.date!
            let value = transaction.volume?.doubleValue
            result.append((categoryId: category, date: date, value: value!))
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
        let filtredByDate = reportData.filter({ $0.date == selected })//dateFormatter.string(from: $0.date) == dateFormatter.string(from: selected) })
        for instance in filtredByDate {
            result.append((model.getCategoryName(byId: instance.categoryId)!, instance.value))
        }
        return result
    }
}
