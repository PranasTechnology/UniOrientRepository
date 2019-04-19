//
//  multiTableViewCell.swift
//  UniOrient
//
//  Created by Pranas on 19/04/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class multiTableViewCell: UITableViewCell {

    @IBOutlet weak var flightName: UILabel!
    @IBOutlet weak var lblRefundable: UILabel!
    @IBOutlet weak var flightImg: UIImageView!
    @IBOutlet weak var departTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var reflightName: UILabel!
    @IBOutlet weak var reRefundable: UILabel!
    @IBOutlet weak var reDuration: UILabel!
    @IBOutlet weak var reDepartTime: UILabel!
    @IBOutlet weak var reflightImg: UIImageView!
    
    @IBOutlet weak var multiflightName: UILabel!
    @IBOutlet weak var multilblRefundable: UILabel!
    @IBOutlet weak var multiflightImg: UIImageView!
    @IBOutlet weak var multidepartTime: UILabel!
    @IBOutlet weak var multiduration: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
