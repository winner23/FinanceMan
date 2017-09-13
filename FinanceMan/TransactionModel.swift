//
//  TransactionModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class TransactionModel: NSObject, NSCoding {
    
    private var _id: String = ""
    private var _category: CategoryModel?
    private var _bill: NSDecimalNumber?
    private var descriptionTransaction: String?
    private var _date: Date?
    
    
    //magic numbers :)
    //Only two numbers after a point are taken into account
    //two last digits in _bill for bit rate
    private let bitRate = 100
    private let dateFormatter = DateFormatter()
    
    init(category: CategoryModel, bill: String, date: String) {
        self._id = UUID().uuidString
        self._category = category
        self._bill = NSDecimalNumber(string: bill)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self._date = dateFormatter.date(from: date)
    }
    
    //NSCoder import
    required init(coder decoder: NSCoder) {
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            _id = idDecode
        }
        if let categoryDecode = decoder.decodeObject(forKey: "category") as? CategoryModel {
            _category = categoryDecode
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
        aCoder.encode(_id, forKey: "id")
        aCoder.encode(_category, forKey: "category")
        aCoder.encode(_bill, forKey: "bill")
        aCoder.encode(_date, forKey: "date")
    }
    
    //Getters and Setters
    //id:String
    private var id: String {
        get {
            return _id
        }
        set {
            if _id == "" {
                _id = newValue
            } else {
                _id = UUID().uuidString
            }
        }
    }
    
    //category:Category
    private var category: CategoryModel {
        get {
            return _category!
        }
        set {
            _category = newValue
        }
    }
    
    private var bill: Double {
        get{
            return (_bill?.doubleValue)!
        }
        set {
            _bill = NSDecimalNumber(value: newValue)
        }
    }
    
    private var billStr: String {
        get{
            return (_bill?.stringValue)!
        }
        set{
            _bill = NSDecimalNumber(string: newValue)
        }
    }
    private var date: String {
        get{
            return dateFormatter.string(from:_date!)

        }
        set{
            _date = dateFormatter.date(from:newValue)
            
        }
    }
    
}
