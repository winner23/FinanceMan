//
//  TransactionModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class TransactionModel: NSObject, NSCoding {
    
    private var _categoryId: String = ""
    private var _bill: NSDecimalNumber?
    private var descriptionTransaction: String?
    private var _date: Date?
    
    private let dateFormatter = DateFormatter()
    
    init(categoryId: String, bill: String, date: String) {
        
        self._categoryId = categoryId
        self._bill = NSDecimalNumber(string: bill)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self._date = dateFormatter.date(from: date)
    }
    
    //NSCoder import
    required init(coder decoder: NSCoder) {

        if let categoryDecode = decoder.decodeObject(forKey: "category_id") as? String {
            _categoryId = categoryDecode
        }
        if let billDecode = decoder.decodeObject(forKey: "bill") as? NSDecimalNumber {
            _bill = billDecode
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateDecode = decoder.decodeObject(forKey: "date") as? Date {
            _date = dateDecode
        }
    }
    
    //NSCoder export
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_categoryId, forKey: "category_id")
        aCoder.encode(_bill, forKey: "bill")
        aCoder.encode(_date, forKey: "date")
    }
    
    //Getters and Setters
    //category:Category
    func getCategoryId() -> String {
        return _categoryId
    }
    
    var bill: Double {
        get{
            return (_bill?.doubleValue)!
        }
        set {
            _bill = NSDecimalNumber(value: newValue)
        }
    }
    
    var billStr: String {
        get{
            return (_bill?.stringValue)!
        }
        set{
            _bill = NSDecimalNumber(string: newValue)
        }
    }
    var date: String {
        get{
            return dateFormatter.string(from:_date!)

        }
        set{
            _date = dateFormatter.date(from:newValue)
            
        }
    }
    
}
