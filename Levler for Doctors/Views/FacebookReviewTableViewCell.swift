//
//  FacebookReviewTableViewCell.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class FacebookReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var fimg: UIImageView!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var frate: UILabel!
    @IBOutlet weak var fdes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
