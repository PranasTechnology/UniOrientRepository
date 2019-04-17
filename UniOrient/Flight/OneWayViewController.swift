//
//  OneWayViewController.swift
//  UniOrient
//
//  Created by Pranas on 16/04/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class OneWayViewController: UIViewController
{
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var nonstopImg: UIImageView!
    var dateFormatter = DateFormatter()
    var className : [String] = [String]()
    var arrAdult : [String] = [String]()
    var arrChild : [String] = [String]()
    var arrInfant : [String] = [String]()
    
    var temp : String = String()
    var temp1 : String = String()
    var temps : String = String()
    var temps1 : String = String()
    
    var strAdult = "", strChild = "", strInfant : String = ""
    var isFlipped: Bool = false
    var wayType : String = String()
    
    @IBOutlet weak var txtDeparture: UITextField!
    @IBOutlet weak var txtArrival: UITextField!
    @IBOutlet weak var lblDepartureCity: UILabel!
    @IBOutlet weak var lblArrivalCity: UILabel!
    @IBOutlet weak var txtDepartureDate: UITextField!
    @IBOutlet weak var lblDepartureDay: UILabel!
    @IBOutlet weak var txtArrivalDate: UITextField!
    @IBOutlet weak var lblArrivalDay: UILabel!
    @IBOutlet weak var txtTraveller: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var classChooseView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var travellerView: UIView!
    @IBOutlet weak var travelView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    
    override func viewDidLoad() {
      //  self.loaderWidthConstraint.constant = self.isProcessing ? 20.0 : 0.0
        super.viewDidLoad()
  
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.view .addSubview(onewayView)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popupSegue" {
//            let vc = segue.destination as! PopupViewController
//            vc.options = options
//            vc.dataCount = dataCount
//            vc.reloadClosure = { self.reload() }
        }
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
