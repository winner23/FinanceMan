//
//  RCButton.swift
//  FinanceMan
//
//  Created by Володимир on 9/8/17.
//  Copyright © 2017 Володимир. All rights reserved.
//

import UIKit

class RCButton: UIButton {
    required init() {
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.height / 3
        clipsToBounds = true
    }

}

