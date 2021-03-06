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
    
    @objc func showTable(){
        self.performSegue(withIdentifier: "showTable", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationItem = self.navigationItem
        navigationItem.title = "Report"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(self.showTable));
        navigationItem.rightBarButtonItem = doneItem;
        earningsLabel?.text = earnings ?? ""
        outgoingLabel?.text = outgoing ?? ""
        totalLabel?.text = total ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if reportViewByCategory != nil {
            if (reportViewByCategory?.count)!<1 {
                containerView.addSubview(getWarningMsgLable("No Data for Category!"))
            } else {
                self.barChartView = BarChartView()
                defineChartView(chartView: barChartView)
                drawChartCategory()
            }
        }
        if reportViewByDate != nil {
            if (reportViewByDate?.count)!<1 {
                containerView.addSubview(getWarningMsgLable("No Data for Period!"))
            } else {
                self.pieChartView = PieChartView()
                defineChartView(chartView: pieChartView)
                drawChartDate()
            }
        }
    }
    
    //Get Warning lable
    func getWarningMsgLable(_ textWarning: String) -> UILabel {
        let warningMessage = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        warningMessage.center.x = containerView.center.x
        warningMessage.center.y = containerView.center.y / 2
        warningMessage.textColor = UIColor.white
        warningMessage.backgroundColor = UIColor.red
        warningMessage.textAlignment = .center
        warningMessage.text = textWarning
        return warningMessage
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
        guard let reportViewByCategory = reportViewByCategory else {return}
        guard let barChartView = barChartView else { return }
        var dataEntries: [BarChartDataEntry] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MMM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var xvalues: [String] = []
        let shiftForDate = 0.5
        for i in 0..<(reportViewByCategory.count) {
            let value = reportViewByCategory[i].value
            let date = reportViewByCategory[i].date
            xvalues.append(dateFormatter.string(from: date))
            let dataEntry = BarChartDataEntry(x: Double(i) + shiftForDate, y: value)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Dates")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = ChartColorTemplates.colorful()
        //Chart setup
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .top
        xAxis.labelCount = reportViewByCategory.count
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.granularityEnabled = true
        xAxis.granularity = 1.0
        xAxis.centerAxisLabelsEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        let rightAxis = barChartView.rightAxis
        rightAxis.enabled = false
        let leftAxis = barChartView.leftAxis
        leftAxis.drawZeroLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xvalues)
//        barChartView.animate(xAxisDuration: 0.7, yAxisDuration: 0.7)
        barChartView.data = chartData
        barChartView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1)
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
        dataSet.xValuePosition = .outsideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.valueLinePart1Length = 0.5
        dataSet.entryLabelColor = UIColor.black
        dataSet.valueTextColor = UIColor.blue
        
        pieChartView?.data = data
        pieChartView?.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1)
        pieChartView?.notifyDataSetChanged()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTable" {
            let reportTableViewController = (segue.destination) as? ReportTableViewController
            reportTableViewController?.reportViewByCategory = reportViewByCategory
            reportTableViewController?.reportViewByDate = reportViewByDate
        }
    }
}
extension ReportResultsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
