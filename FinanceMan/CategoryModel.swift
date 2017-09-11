//
//  CategoryModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CategoryModel:NSObject, NSCoding {
    
    private var id: UInt = 0
    private var name: String = ""
    var descriptionContext: String = ""
    
    func getName() -> String {
        return self.name
    }
    
    init(name: String) {
        self.name = name
        self.id = 0
        
    }
    
    init(ID id:UInt, CategoryName name:String) {
        self.name = name
        self.id = id
    }
    
    required init(coder decoder: NSCoder) {
        
        if let idDecode = decoder.decodeObject(forKey: "id") as? UInt {
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
    
    
    
}
