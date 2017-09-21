//
//  CategoryTableViewCell.swift
//  FinanceMan
//
//  Created by Володимир on 9/17/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var categoryCellView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
