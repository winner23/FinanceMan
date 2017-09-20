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
    private var type = false //True - income / False - pay
    private var icon: String = "💵"
    
    
//    init(name: String) {
//        self.name = name
//        self.id = UUID().uuidString
//        
//    }
    
    init(categoryName name:String, descriptionCategory descript:String, isIncome type: Bool, icon: String) {
        self.name = name
        self.id = UUID().uuidString
        self.descriptionContext = descript
        self.type = type
        self.icon = icon
    }
    
    override init() {
        super.init()
    }
    //Load properties from external file
    required init(coder decoder: NSCoder) {
        
        if let idDecode = decoder.decodeObject(forKey: "id") as? String {
            id = idDecode
            name = decoder.decodeObject(forKey: "name") as? String ?? "noname"
            descriptionContext = decoder.decodeObject(forKey: "descriptionContext") as? String ?? ""
            type = decoder.decodeObject(forKey: "type") as? Bool ?? false
            icon = decoder.decodeObject(forKey: "icon") as? String ?? "💵"
        }
        
    }
    //Save properties to external file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        if descriptionContext != "" {
                aCoder.encode(descriptionContext, forKey: "descriptionContext")
        }
        aCoder.encode(type, forKey: "type")
        aCoder.encode(icon, forKey: "icon")
    }
    
    //Public Manage
    func getName() -> String {
        return name
    }
    
    func getId() -> String{
        return id
    }
    
    func getDescription() -> String {
        return descriptionContext
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setDescription(text: String) {
        descriptionContext = text
    }
    
    func isIncome() -> Bool{
        return type
    }
    func switchType() {
        type = !type
    }
    
    func getIcon() -> String {
        return icon
    }
    
    func setIcon(icon: String) {
        self.icon = icon
    }
    
}
