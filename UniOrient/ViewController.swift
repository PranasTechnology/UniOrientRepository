//
//  ViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 02/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var testBtn: UIButton!
    
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var lblFLight: UILabel!
    @IBOutlet weak var lblHotel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // Circled VIew
        flightView.layer.cornerRadius = flightView.frame.size.width/2
        flightView.clipsToBounds = true
        flightView.layer.borderColor = UIColor.white.cgColor
        flightView.layer.borderWidth = 1.0
        
        hotelView.layer.cornerRadius = hotelView.frame.size.width/2
        hotelView.clipsToBounds = true
        hotelView.layer.borderColor = UIColor.white.cgColor
        hotelView.layer.borderWidth = 1.0
        
        //Gesture View
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        flightView.addGestureRecognizer(tap1)
        flightView.isUserInteractionEnabled = true
      
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        hotelView.addGestureRecognizer(tap2)
        hotelView.isUserInteractionEnabled = true
    }

    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "flightSearchVC") as? FlightSearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
  
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "flightSearchVC") as? FlightSearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func homeBtn(_ sender: Any)
    {
        
    }
    @IBAction func myaccountBtn(_ sender: Any)
    {
        
    }
    @IBAction func myBookingBtn(_ sender: Any)
    {
        
    }
}
