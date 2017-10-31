//
//  GoogleReviewTableViewCell.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class GoogleReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var gimg: UIImageView!
    @IBOutlet weak var gname: UILabel!
    @IBOutlet weak var grate: UILabel!
    @IBOutlet weak var gdes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
