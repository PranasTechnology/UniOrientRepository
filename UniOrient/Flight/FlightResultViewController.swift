//
//  FlightResultViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 12/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit
//import Alamofire
//import onewayTableViewCell

class FlightResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var onewayTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var gif1: UIImageView!
    @IBOutlet weak var gif2: UIImageView!
    @IBOutlet weak var gif3: UIImageView!
    @IBOutlet weak var gif4: UIImageView!
    @IBOutlet weak var gif5: UIImageView!
    var arrflightName : [String] = [String]()
    var arrflightImg : [String] = [String]()
    var arrArrivalTime : [String] = [String]()
    var arrDepartureTime : [String] = [String]()
    var arrDuration : [String] = [String]()
    var arrStops : [String] = [String]()
     var arrAmount : [String] = [String]()
     var arrFareType : [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
           loadingView .isHidden = false;
//        let imageData = try! Data(contentsOf: Bundle.main.url(forResource: "loadingHotelGif", withExtension: "gif")!)
//       gif1.image = UIImage.gif(data: imageData)
//
         gif1.image = UIImage.gif(name: "loadingHotelGif")
         gif2.image = UIImage.gif(name: "loadingHotelGif")
         gif3.image = UIImage.gif(name: "loadingHotelGif")
         gif4.image = UIImage.gif(name: "loadingHotelGif")
         gif5.image = UIImage.gif(name: "loadingHotelGif")
      self.getFlightResult()
    }
    
    func getFlightResult ()
    {
        let parameters: [String: AnyObject] = [
            "Origin" : "MAA" as AnyObject,
            "Destination" : "BOM" as AnyObject,
            "DepartureDate" : "2019-01-23" as AnyObject,
            "Returndate": "2019-01-25" as AnyObject,
            "type" : "one" as AnyObject,
            "CabinClass" : "Economy" as AnyObject,
            "AdultCount": "2" as AnyObject,
            "ChildCount" : "0" as AnyObject,
            "InfantCount" : "0" as AnyObject,
            "SeniorCount" : "0" as AnyObject,
            "PreferredCarrier": "1" as AnyObject,
            "PromotionalPlanType" : "0" as AnyObject,
            "SearchSessionid" : "0" as AnyObject,
            "moduleid" : "14" as AnyObject,
            "ParentAccountId": "IXCRAJ042" as AnyObject,
            "ChildAccountId" : "IXCRAJ042" as AnyObject,
            "ReqType": "JSON" as AnyObject,
            "pptype" : "0" as AnyObject,
            "category": "0" as AnyObject,
            "IsSplFare": "true" as AnyObject
        ]

    }
  
    
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
   
 
  
    ///Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrflightName.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "onewaycell", for: indexPath as IndexPath) as UITableViewCell
     
        let blueView = cell.viewWithTag(10)
        blueView?.layer.cornerRadius = 5
        blueView?.layer.borderWidth = 0.1
        blueView?.layer.borderColor = UIColor.orange.cgColor
        blueView?.layer.shadowColor = UIColor.yellow.cgColor
        blueView?.layer.shadowOffset = CGSize(width: 3, height: 3)
        blueView?.layer.shadowOpacity = 0.7
        blueView?.layer.shadowRadius = 4.0
        
        let img1 = cell.viewWithTag(1) as! UIImageView
        let label2 = cell.viewWithTag(2) as! UILabel
        let label3 = cell.viewWithTag(3) as! UILabel
        let label4 = cell.viewWithTag(4) as! UILabel
        let label5 = cell.viewWithTag(5) as! UILabel
        let label6 = cell.viewWithTag(6) as! UILabel
        let label7 = cell.viewWithTag(7) as! UILabel
       // let label8 = cell.viewWithTag(8) as! UILabel
        let label9 = cell.viewWithTag(9) as! UILabel
        
        if(arrflightName[indexPath.row] .contains(","))
        {
             label2.text = "Multi Airlines"
        }
        else{
             label2.text = arrflightName[indexPath.row]
        }
        let inputString = arrDepartureTime[indexPath.row]
        var splits = inputString.components(separatedBy: "T")
        splits = [String(splits[1].dropLast(3))]
        print(splits)
     //   label3.text = arrDepartureTime[indexPath.row]
    //    label4.text = arrArrivalTime[indexPath.row]
      //  label5.text = arrDuration[indexPath.row]
        label6.text = arrStops[indexPath.row]
        label7.text = arrFareType[indexPath.row]
       // label8.text = arrflightName[indexPath.row]
     // label9.text = "Rs \(String(describing: arrAmount[indexPath.row]))"
        //String(arrAmount[indexPath.row])// as String
        return cell
    }
}

