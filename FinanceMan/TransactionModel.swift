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
    private var description: String?
    
    //magic numbers :)
    //Only two numbers after a point are taken into account
    //two last digits in _bill for bit rate
    private let bitRate = 100
    
    init(category: CategoryModel, bill: String) {
        self._id = UUID().uuidString
        self._category = category
        self.billStr = bill
    }
  
    required init(coder decoder: NSCoder) {
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            _id = idDecode
        }
        if let categoryDecode = decoder.decodeObject(forKey: "category") as? CategoryModel {
            _category = categoryDecode
        }
        if let billDecode = decoder.decodeObject(forKey: "bill") as? Int {
            _bill = billDecode
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(bill, forKey: "bill")
    }
    
    private var id: String {
        set {
            if _id == "" {
               _id = newValue
            }
        }
        get {
            return _id
        }
    }
    private var category: CategoryModel {
        get {
            return _category!
        }
        set {
            _category = newValue
        }
    }
    
    
    private var billStr: String {
        get {
            return int2str(_bill)
        }
        set {
            str2int(newValue)
        }
    }
    
    private var bill: Double {
        get{
            return int2double(_bill)
        }
        set {
            _bill = double2int(newValue)
        }
    }
    
    //convert from Internal Integer format to Double
    func int2double(int: Int) -> Double{
        return Double(int / bitRate) + (Double(Double(int % bitRate) / Double(bitRate)))
    }
    
    //convert from Double to Internal Integer format
    //Only two numbers after a point are taken into account
    func double2int(double: Double) -> Int{
        return Int(double * bitRate)
    }
    
    //convert from String to the Internal Integer format
    func str2int(str: String) -> Int{
        
        if let _ = Double(str) {
            let billPars = str.components(separatedBy: ".")
            return (Int(billPars[0])!) * bitRate + Int(billPars[1])!
        }
    }
    //convert from internal Integer to String
    func int2str(int: Int) -> String{
        
        if (int % bitRate) > 1 {
            let integerPart = int / bitRate
            let floatPart = int - integerPart
            return "\(integerPart).\(floatPart)"
        }
        return "\(int / bitRate)"
    }
}
