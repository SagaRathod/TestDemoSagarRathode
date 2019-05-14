//
//  CustomTableViewCell.swift
//  TestDemoSagarRathode
//
//  Created by appbellmac on 14/05/19.
//  Copyright ©  2019 Sagar Rathode All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
