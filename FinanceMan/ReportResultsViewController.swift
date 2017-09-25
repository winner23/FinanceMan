//
//  ReportResultsViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/22/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit
import Charts

class ReportResultsViewController: UIViewController {

    
    @IBOutlet weak var earningsLabel: UILabel?
    @IBOutlet weak var outgoingLabel: UILabel?
    @IBOutlet weak var totalLabel: UILabel?
    @IBOutlet weak var chartView: BarChartView!
    
    var earnings: String?
    var outgoing: String?
    var total: String?
    var reportViewByCategory: [(date: Date, value: NSDecimalNumber)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        earningsLabel?.text = earnings ?? ""
        outgoingLabel?.text = outgoing ?? ""
        totalLabel?.text = total ?? ""
        drawChart()
        
        // Do any additional setup after loading the view.
    }
    
    func drawChart(){
        var dataEntries: [BarChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0..<reportViewByCategory.count {
            let value = reportViewByCategory[i].value.doubleValue
            let dataEntry = BarChartDataEntry(x: Double(i), y: value)//(value: values[i].value, xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units")//(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)//(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData    }

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
