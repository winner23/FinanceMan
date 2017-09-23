//
//  CategoryModel.swift
//  FinanceMan
//
//  Created by Володимир on 9/10/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import Foundation

class CategoryModel:NSObject, NSCoding {
    
    var id: String = ""
    var name: String = ""
    var descriptionContext: String = ""
    var type = false //True - income / False - pay
    var icon: String?
    
    //init for temporary instance
    init(categoryName name:String, descriptionCategory descript:String, isIncome type: Bool, icon: String?) {
        self.name = name
        self.id = UUID().uuidString
        self.descriptionContext = descript
        self.type = type
        self.icon = icon
    }
    //Default init
    override init() {
        super.init()
    }
    
    //Load properties from external file
    required init(coder decoder: NSCoder) {
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            id = idDecode
            name = decoder.decodeObject(forKey: "name") as? String ?? "noname"
            descriptionContext = decoder.decodeObject(forKey: "descriptionContext") as? String ?? ""
            type = decoder.decodeBool(forKey: "type")
            icon = decoder.decodeObject(forKey: "icon") as? String
        }
    }
    
    //Save properties to external file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        if descriptionContext != "" {
                aCoder.encode(descriptionContext, forKey: "descriptionContext")
        }
        //let typeStr = type ? "T" : "F"
        aCoder.encode(type, forKey: "type")//typeStr, forKey: "type")
        aCoder.encode(icon, forKey: "icon")
    }
}
