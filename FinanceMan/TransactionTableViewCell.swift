//
//  TransactionTableViewCell.swift
//  FinanceMan
//
//  Created by Володимир on 9/17/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descript: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
