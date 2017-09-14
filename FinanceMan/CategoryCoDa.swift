//
//  CategoryCoDa.swift
//  FinanceMan
//
//  Created by ITA student on 9/14/17.
//  Copyright © 2017 Володимир. All rights reserved.
//
import CoreData

class CategoryCoDa{
    private var categories: Categories?
    
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Fanance")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    

    
}
