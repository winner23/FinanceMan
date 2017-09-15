//
//  TransactionModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class TransactionModel: NSObject, NSCoding {
    
    private var categoryId: String = ""
    private var volume: NSDecimalNumber?
    private var descriptionTransaction: String?
    private var date: Date?
    
    private let dateFormatter = DateFormatter()
    
    init(categoryID: String, volume: String, date: String) {
        self.categoryId = categoryID
        self.volume = NSDecimalNumber(string: volume)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.date(from: date)
    }
    
    //NSCoder import
    required init(coder decoder: NSCoder) {

        if let categoryDecode = decoder.decodeObject(forKey: "category_id") as? String {
            categoryId = categoryDecode
        }
        if let volumeDecode = decoder.decodeObject(forKey: "bill") as? NSDecimalNumber {
            volume = volumeDecode
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateDecode = decoder.decodeObject(forKey: "date") as? Date {
            date = dateDecode
        }
    }
    
    //NSCoder export
    func encode(with aCoder: NSCoder) {
        aCoder.encode(categoryId, forKey: "category_id")
        aCoder.encode(volume, forKey: "bill")
        aCoder.encode(date, forKey: "date")
    }
    
    func getCategoryId() -> String {
        return categoryId
    }
    
    
    
}
