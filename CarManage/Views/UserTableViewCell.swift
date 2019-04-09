//
//  UserTableViewCell.swift
//  CarManage
//
//  Created by GOgi on 4/6/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import UIKit
import SwipeCellKit

class UserTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRemove: MyButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
