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
    
    init(categoryID: String, volume: String, descriptionText: String, date: Date) {
        self.categoryId = categoryID
        
        self.volume = NSDecimalNumber(string: volume)
        
        self.date = date
        //dateFormatter.dateFormat = "yyyy-MM-dd"
        self.descriptionTransaction = descriptionText
    }
    
    override init(){
        super.init()
    }
    
    //NSCoder import
    required init(coder decoder: NSCoder) {

    
        if let categoryDecode = decoder.decodeObject(forKey: "category_id") as? String {
            categoryId = categoryDecode
        }
        if let volumeDecode = decoder.decodeObject(forKey: "bill") as? NSDecimalNumber {
            volume = volumeDecode
        }
        
        if let dateDecode = decoder.decodeObject(forKey: "date") as? Date {
            date = dateDecode
        }
        if let descriptionDecode = decoder.decodeObject(forKey: "descripTransac") as? String {
            descriptionTransaction = descriptionDecode
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
    
    func setCategory(id: String) {
        categoryId = id
    }
    
    func getDescription() -> String {
        return descriptionTransaction ?? ""
    }
    
    func setDescription(descriptionText: String) {
        descriptionTransaction = descriptionText
    }
    
    func getDate() -> Date? {
        return date
    }
    
    func getVolumeDouble() -> Double? {
        let result = Double(volume!)
        return result
        
    }
    func getVolumeString() -> String {
        let result = String(describing: volume!)
        return result
    }
    
}
