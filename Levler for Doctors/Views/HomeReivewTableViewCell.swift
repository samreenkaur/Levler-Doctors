//
//  HomeReivewTableViewCell.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class HomeReivewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewname: UILabel!
    @IBOutlet weak var reviewDes: UILabel!
    @IBOutlet weak var reviewrate: UILabel!
    @IBOutlet weak var reviewimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
