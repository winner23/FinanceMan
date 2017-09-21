//
//  ReportViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/22/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var ctegorySelector: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    @IBAction func reportByCategory(_ sender: UIButton) {
    }
    
    @IBAction func reportOnDate(_ sender: UIButton) {
    }
    
    
    
    @IBAction func reportBetween(_ sender: UIButton) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
