//
//  ViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/8/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Transactions");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        navItem.rightBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
        // Do any additional setup after loading the view, typically from a nib.
    }

    


}

