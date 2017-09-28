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
    var reportViewByCategory: [(date: Date, value: Double)]?
    var reportViewByDate: [(categoryName: String, value: Double, type: CategoryType)]?
    
    var barChartView: BarChartView?
    var pieChartView: PieChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        earningsLabel?.text = earnings ?? ""
        outgoingLabel?.text = outgoing ?? ""
        totalLabel?.text = total ?? ""
        if reportViewByCategory != nil {
            self.barChartView = BarChartView()
            defineChartView(chartView: barChartView)
            drawChartCategory()
        }
        if reportViewByDate != nil {
            self.pieChartView = PieChartView()
            defineChartView(chartView: pieChartView)
            drawChartDate()
        }
    }
    //Set constraints for view of charts
    func defineChartView(chartView: UIView?){
        guard let viewDef = chartView else {
            return
        }
        viewDef.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(chartView!)
        let horConstraint = NSLayoutConstraint(item: viewDef, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let verConstraint = NSLayoutConstraint(item: viewDef, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widConstraint = NSLayoutConstraint(item: viewDef, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.99, constant: 0.0)
        let heiConstraint = NSLayoutConstraint(item: viewDef, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 0.99, constant: 0.0)
        containerView.addConstraints([horConstraint, verConstraint, widConstraint, heiConstraint])
    }
    
    func drawChartCategory(){
        var dataEntries: [BarChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        for i in 0..<(reportViewByCategory!.count) {
            let value = reportViewByCategory![i].value
            let dataEntry = BarChartDataEntry(x: Double(i), y: value)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Dates")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = ChartColorTemplates.colorful()
        if barChartView != nil {
            barChartView!.data = chartData
        }
        barChartView?.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1)
        
    }
    
    func drawChartDate() {
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<(reportViewByDate!.count){
           let category = reportViewByDate![i].categoryName
           let value = reportViewByDate![i].value
            let dataEntry = PieChartDataEntry(value: value, label: category)
            dataEntries.append(dataEntry)
        }
        let dataSet = PieChartDataSet(values: dataEntries, label: "Categories")
        let data = PieChartData(dataSet: dataSet)
        dataSet.colors = ChartColorTemplates.colorful()
        pieChartView?.data = data
        pieChartView?.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1)
        pieChartView?.notifyDataSetChanged()
    }
}
