//
//  ReportTableViewController.swift
//  FinanceMan
//
//  Created by Володимир on 9/29/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class ReportTableViewController: UITableViewController {

    var reportViewByCategory: [(date: Date, value: Double)]?
    var reportViewByDate: [(categoryName: String, value: Double, type: CategoryType)]?
    private var checkData = false
    private let model = CoreModel.coreModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkData = reportViewByDate == nil
        checkData = reportViewByCategory != nil
        if !checkData {
            guard let reportViewByDateOver = reportViewByDate else { return }
            let sortedReportViewByDate = reportViewByDateOver.sorted(by: {$0.value > $1.value})
            reportViewByDate = sortedReportViewByDate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkData {
            guard let reportViewByCategory = reportViewByCategory else { return 0 }
            return reportViewByCategory.count
        } else {
            guard let reportViewByDate = reportViewByDate else { return 0 }
            return reportViewByDate.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportTableViewCell
        if checkData {
            guard let reportViewByCategory = reportViewByCategory else { return cell }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            cell.name.text = dateFormatter.string(from: reportViewByCategory[indexPath.row].date)
            cell.value.text = "\(reportViewByCategory[indexPath.row].value)"
            cell.icon.text = ""
        } else {
            guard let reportViewByDate = reportViewByDate else { return cell }
            cell.name.text = "\(reportViewByDate[indexPath.row].categoryName)"
            cell.value.text = "\(reportViewByDate[indexPath.row].value)"
            if let categoryID = model.getCategoryId(byName: reportViewByDate[indexPath.row].categoryName){
                let categoryInstance = model.getCategoryInstance(byId: categoryID)
                cell.icon.text = categoryInstance?.icon
            }
            let color = reportViewByDate[indexPath.row].type == CategoryType.income ? UIColor(red: 241/255, green: 230/255, blue: 245/255, alpha: 1) : UIColor(red: 241/255, green: 243/255, blue: 230/255, alpha: 1)
            cell.backgroundColor = color
        }
        

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
