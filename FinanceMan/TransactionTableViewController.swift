//
//  TransactionTableViewController.swift
//  FinanceMan
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class TransactionTableViewController: UITableViewController {

    private let model = CoreModel.coreModel
    
    @IBOutlet var transactionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationItem = self.navigationItem
        navigationItem.title = "Transactions"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.openNewTransactionView))
        let menuItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(self.openReportView))
        navigationItem.rightBarButtonItem = doneItem
        navigationItem.leftBarButtonItem = menuItem
        super.viewWillAppear(animated)
        model.retrievTranactions()
        model.retrievCategories()
        transactionTable.reloadData()
    }

    @objc func openNewTransactionView(){
        self.performSegue(withIdentifier: "newTransaction", sender: self)
    }
    
    @objc func openReportView(){
        self.performSegue(withIdentifier: "reportView", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.transactions.count
    }

    //Fill rows of tabel
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        let transactionInstance = model.getTransactionInstance(byIndex: indexPath.row)!
        if let dateTransaction = transactionInstance.date{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let dateStr = formatter.string(from: dateTransaction)
            cell.date.text = dateStr
        }
        let valueTransaction = transactionInstance.getVolumeString()
        let transactionCategoryInstance = model.getCategoryInstance(byId: transactionInstance.categoryId)
        cell.icon.text = transactionCategoryInstance?.icon
        cell.name.text = transactionCategoryInstance?.name
        cell.descript.text = transactionInstance.descriptionTransaction
        cell.value.text = valueTransaction
        if (transactionCategoryInstance?.type)! {
            cell.type.text = "⬇︎"
            cell.type.textColor = UIColor(red: 0, green: 255, blue: 0)
        } else {
            cell.type.text = "⬆︎"
            cell.type.textColor = UIColor(red: 0, green: 0, blue: 255)
        }
        return cell
    }
    
    //Define function(swipe) button
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Del") { action, index in
            self.model.deleteTransactio(byIndex: indexPath.row)
            self.transactionTable.beginUpdates()
            self.transactionTable.deleteRows(at: [indexPath], with: .automatic)
            self.transactionTable.endUpdates()
            self.model.saveTransactions()
        }
        return [delete]
    }

    //Edit transaction
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editTransaction", sender: indexPath.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTransaction" {
            let editTransactionViewController = (segue.destination as? TransactionViewController)!
            let transactionIndex = sender as? Int
            editTransactionViewController.currentTransactionIndex = transactionIndex
            editTransactionViewController.currentTransaction = model.getTransactionInstance(byIndex: transactionIndex!)
        }
    }
}
