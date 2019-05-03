//
//  MyBookingsViewController.swift
//  UniOrient
//
//  Created by Pranas on 03/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class MyBookingsViewController: UIViewController {

    @IBOutlet weak var segmentViewController: UISegmentedControl!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var completedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.completedView.isHidden = false
        self.upcomingView.isHidden = true
        self.upcomingTableView.isHidden = true
        self.completedTableView.isHidden = true
    }
    
    @IBAction func segmentControlAction(_ sender: Any)
    {
        switch segmentViewController.selectedSegmentIndex
        {
        case 0:
            self.completedView.isHidden = false
            self.upcomingView.isHidden = true
        case 1:
            self.completedView.isHidden = true
            self.upcomingView.isHidden = false
        default:
            break
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class completedTableViewCell :  UITableViewCell
{
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var flightView: UIView!
    
    @IBOutlet weak var fModule: UILabel!
    @IBOutlet weak var fAmount: UILabel!
    @IBOutlet weak var fTransId: UILabel!
    @IBOutlet weak var fTransDate: UILabel!
    
    @IBOutlet weak var fPNRNumber: UILabel!
    @IBOutlet weak var fArrival: UILabel!
    @IBOutlet weak var fDeparture: UILabel!
    ////Hotel
    @IBOutlet weak var hModule: UILabel!
    @IBOutlet weak var hAmount: UILabel!
    @IBOutlet weak var hTransId: UILabel!
    @IBOutlet weak var hTransDate: UILabel!
    @IBOutlet weak var hCity: UILabel!
    @IBOutlet weak var hBookingNumber: UILabel!
}
class upcomingTableViewCell :  UITableViewCell
{
    
    @IBOutlet weak var hModule: UILabel!
    @IBOutlet weak var hTransId: UILabel!
    @IBOutlet weak var hTransDate: UILabel!
}
