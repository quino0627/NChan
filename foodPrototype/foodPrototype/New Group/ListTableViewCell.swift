//
//  ListTableViewCell.swift
//  foodPrototype
//
//  Created by cscoi005 on 2018. 8. 7..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listProduct: UILabel!
    @IBOutlet weak var listPrice: UILabel!
    @IBOutlet weak var listPlace: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
