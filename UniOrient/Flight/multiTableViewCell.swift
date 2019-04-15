//
//  multiTableViewCell.swift
//  UniOrient
//
//  Created by Pranas on 15/04/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class multiTableViewCell: UITableViewCell {

    var cellDelegate: YourCellDelegate?
    @IBOutlet weak var departBtn: UIButton!
  
    // connect the button from your cell with this method
    @IBAction func departBtnPressed(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }
    @IBOutlet weak var arriBtn: UIButton!
    // connect the button from your cell with this method
    @IBAction func arriBtnPressed(_ sender: UIButton) {
       // cellDelegate?.didPressButton(sender.tag)
    }
    @IBOutlet weak var departDateBtn: UIButton!
    // connect the button from your cell with this method
    @IBAction func departDateBtnPressed(_ sender: UIButton) {
      //  cellDelegate?.didPressButton(sender.tag)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
