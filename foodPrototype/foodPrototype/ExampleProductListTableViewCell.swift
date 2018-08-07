//
//  ExampleProductListTableViewCell.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

class ExampleProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
