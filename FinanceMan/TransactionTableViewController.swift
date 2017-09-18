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
    private var transactions:[TransactionModel] = []
    
    @IBOutlet var transactionTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.transactions = model.getTransactions()
        
        //let navigationBar = self.navigationController?.navigationBar
        let navigationItem = self.navigationItem
        navigationItem.title = "Transactions"
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.openNewView));
        
    
        navigationItem.rightBarButtonItem = doneItem;
        
        //navigationBar?.setItems([navigationItem], animated: true);
        //navigationItem.setRightBarButtonItem(addButtonItem, animated: true)
        transactionTable.reloadData()
        super.viewWillAppear(animated)
        
        model.retrievTranactions()
    }

    func openNewView(){
        self.performSegue(withIdentifier: "newTransaction", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getTransactions().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        
        let transactionCategoryId = transactions[indexPath.row].getCategoryId()
        let transactionCategory = model.getCategoryName(byId: transactionCategoryId)
            
        cell.name.text = transactionCategory ?? "No category"
        cell.descript.text = transactions[indexPath.row].getDescription()
        // Configure the cell...

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

   
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
