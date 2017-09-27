//
//  CategoryModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

enum CategoryType{
    case income
    case pay
}

class CategoryModel:NSObject, NSCoding {
    
    
    
    var id: String = ""
    var name: String = ""
    var descriptionContext: String = ""
    var type: CategoryType
    var icon: String?
    
    //init for temporary instance
    init(categoryName name:String, descriptionCategory descript:String, isIncome type: CategoryType, icon: String?) {
        self.name = name
        self.id = UUID().uuidString
        self.descriptionContext = descript
        self.type = type
        self.icon = icon
    }
    
    //Load properties from external file
    required init(coder decoder: NSCoder) {
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            id = idDecode
            name = decoder.decodeObject(forKey: "name") as? String ?? "noname"
            descriptionContext = decoder.decodeObject(forKey: "descriptionContext") as? String ?? ""
            icon = decoder.decodeObject(forKey: "icon") as? String
        }
        type = decoder.decodeBool(forKey: "type") ? .income : .pay
    }
    
    //Save properties to external file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        if descriptionContext != "" {
                aCoder.encode(descriptionContext, forKey: "descriptionContext")
        }
        let typeCover:Bool = (type == .income)
        aCoder.encode(typeCover, forKey: "type")
        aCoder.encode(icon, forKey: "icon")
    }
}
