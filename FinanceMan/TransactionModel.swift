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
    private var _bill = 0
    
    
    
    init(category: CategoryModel, bill: String) {
        self._id = UUID().uuidString
        self._category = category
        self.billStr = bill
    }
    
//    init(category: CategoryModel, bill: Double) {
//        self._id = UUID().uuidString
//        self._category = category
//        self.bill = bill
//    }
    
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
    
    var id: String {
        set {
            if _id == "" {
               _id = newValue
            }
        }
        get {
            return _id
        }
    }
    var category: CategoryModel {
        get {
            return _category!
        }
        set {
            _category = newValue
        }
    }
    
    
    var billStr: String {
        get {
            if _bill%100 > 1 {
                let billInt = _bill / 100
                let billFloat = _bill - billInt
                return "\(billInt).\(billFloat)"
            }
            return "\(_bill / 100)"
        }
        set {
            if let _ = Double(newValue) {
                let billPars = newValue.components(separatedBy: ".")
                _bill = (Int(billPars[0])!) * 100 + Int(billPars[1])!
            }
        }
    }
    
    
    //Only two numbers after a point are taken into account
    var bill: Double {
        get{
            return Double(_bill / 100) + (Double(Double(_bill % 100) / 100.0))
        }
        set {
            _bill = Int(newValue * 100)
        }
    }
    
    
}
