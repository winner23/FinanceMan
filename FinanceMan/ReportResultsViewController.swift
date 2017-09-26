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
    @IBOutlet weak var containerView: UIView!
    
    
    
    var earnings: String?
    var outgoing: String?
    var total: String?
    var reportViewByCategory: [(date: Date, value: NSDecimalNumber)]?
    var reportViewByDate: [(categoryName: String, value: Double)]?
    
    var barChartView: BarChartView?
    var pieChartView: PieChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        earningsLabel?.text = earnings ?? ""
        outgoingLabel?.text = outgoing ?? ""
        totalLabel?.text = total ?? ""
        if reportViewByCategory != nil {
            self.barChartView = BarChartView()
            self.barChartView?.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(self.barChartView!)
            let horConstraint = NSLayoutConstraint(item: barChartView!, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let verConstraint = NSLayoutConstraint(item: barChartView!, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            let widConstraint = NSLayoutConstraint(item: barChartView!, attribute: .width, relatedBy: .equal,
                                                   toItem: containerView, attribute: .width,
                                                   multiplier: 0.95, constant: 0.0)
            let heiConstraint = NSLayoutConstraint(item: barChartView!, attribute: .height, relatedBy: .equal,
                                                   toItem: view, attribute: .height,
                                                   multiplier: 0.95, constant: 0.0)
            
            view.addConstraints([horConstraint, verConstraint, widConstraint, heiConstraint])
            
            drawChartCategory()
        }
        if reportViewByDate != nil {
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func drawChartCategory(){
        var dataEntries: [BarChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0..<(reportViewByCategory!.count) {
            let value = reportViewByCategory![i].value.doubleValue
            let dataEntry = BarChartDataEntry(x: Double(i), y: value)//(value: values[i].value, xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units")//(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)//(xVals: months, dataSet: chartDataSet)
        if barChartView != nil {
            barChartView!.data = chartData
        }
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
