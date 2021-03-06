//
//  CategoryController.swift
//  FinanceMan
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        let navigationItem = self.navigationItem
        navigationItem.title = "Categories"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.openNewView));
        
        
        navigationItem.rightBarButtonItem = doneItem;
        
        
        super.viewWillAppear(animated)
    }
    
    func openNewView(){
        self.performSegue(withIdentifier: "newCategory", sender: self)
    }

}

