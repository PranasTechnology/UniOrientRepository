//
//  onewayTableViewCell.swift
//  TakeMyTravel
//
//  Created by apple1 on 14/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit

class onewayTableViewCell: UITableViewCell {

    @IBOutlet weak var flightImg: UIImageView!
    @IBOutlet weak var flightName: UILabel!
    @IBOutlet weak var departCode: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var departTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var stop: UILabel!
   @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
