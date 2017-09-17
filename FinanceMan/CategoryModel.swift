//
//  CategoryModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CategoryModel:NSObject, NSCoding {
    
    private var id: String = ""
    private var name: String = ""
    private var descriptionContext: String = ""
    
    
    init(name: String) {
        self.name = name
        self.id = UUID().uuidString
        
    }
    
    init(categoryName name:String, descriptionCategory descript:String) {
        self.name = name
        self.id = UUID().uuidString
        self.descriptionContext = descript
    }
    
    override init() {
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            id = idDecode
            name = decoder.decodeObject(forKey: "name") as? String ?? "noname"
            descriptionContext = decoder.decodeObject(forKey: "descriptionContext") as? String ?? ""
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        if descriptionContext != "" {
                aCoder.encode(descriptionContext, forKey: "descriptionContext")
        }
    }
    
    func getName() -> String {
        return name
    }
    
    func getId() -> String{
        return id
    }
    
    func getDescription() -> String {
        return descriptionContext
    }
    
}
