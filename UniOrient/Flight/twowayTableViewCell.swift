//
//  twowayTableViewCell.swift
//  TakeMyTravel
//
//  Created by apple1 on 14/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit

class twowayTableViewCell: UITableViewCell {

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
