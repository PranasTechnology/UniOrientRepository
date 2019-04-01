//
//  FlightResultVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 14/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SDWebImage

class FlightResultVCGoomo: UIViewController {
 
//MARK: - IBOutlet
    @IBOutlet weak var twowayView: UIView!
    @IBOutlet weak var tripDetailDestinationDateLbl: UILabel!
    @IBOutlet weak var tripDetailSourceLbl: UILabel!
    @IBOutlet weak var onewayOrTwowayImgView: UIImageView!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tripDateDetailLbl: UILabel!
    @IBOutlet weak var tripPassengerDetailLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var dataTVContainerView: UIView!
    @IBOutlet weak var bottomView: UIView!
  
    
    @IBOutlet weak var departureBtn: UIButton!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var departureBtnImgView: UIImageView!
    @IBOutlet weak var flightBtnImgView: UIImageView!
    @IBOutlet weak var priceBtnImgView: UIImageView!
    
    
//MARK: - variable Declaration
    
    var arrToDisplay = [FlightResultAndDetailStruct]()
    var arrToSort = [FlightResultAndDetailStruct]()
    var tripDetailDateFormatter = DateFormatter()
    var convertStrToDateDF = DateFormatter()
    var filteredArr = [FlightResultAndDetailStruct]()
    var flightResultAndDetailArrForFilterVC = [FlightResultAndDetailStruct]()
    var inputDict = [String:String]()
    var flightResultArr = [[String:AnyObject]]()
    var flightDetailsArr = [[String:AnyObject]]()
    var flightResultAndDetailsArr = [FlightResultAndDetailStruct]()
    var flightDetailsReturnArr = [[String:AnyObject]]()
    var way : String!
    let dateFormatter = DateFormatter()
 
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
//MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // self.filterBtn.isHidden = true
        //        self.filterBtn.isSelected = false
        
        self.navigationController?.navigationBar.isHidden = false
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        self.dataTV.delegate = self
        self.dataTV.dataSource = self
        
        dataTV.tableFooterView = UIView.init(frame: CGRect.zero)
        
        self.way = self.inputDict["WayType"]!
        print("Way Type = ",self.way)
        print("inputDict from FlightResultVC=",self.inputDict)
        
        convertStrToDateDF.dateFormat = "yyyy-MM-dd"
        tripDetailDateFormatter.dateFormat = "dd MMM"
        
        let stringConvertedToDate = convertStrToDateDF.date(from: self.inputDict["DepartureDate"]!)
        let departureDateStr = tripDetailDateFormatter.string(from: stringConvertedToDate!)
        
        if self.way == "one"{
            self.tripDateDetailLbl.text = departureDateStr + " , One way"
        }else{
            let stringConvertedToDate = convertStrToDateDF.date(from: self.inputDict["Returndate"]!)
            let returnStr = tripDetailDateFormatter.string(from: stringConvertedToDate!)
            self.tripDateDetailLbl.text = departureDateStr + " - " + returnStr + ",Return Trip"
        }
        
        var adultStr,childStr,infantStr : String!
        adultStr = "Adult"
        childStr = "Child"
        infantStr = "Infant"
        
        if Int(self.inputDict["AdultCount"]!)! > 1 {
            adultStr = "Adults"
            //            passengerStr = "\(self.inputDict["AdultCount"]!) \(adultStr!)"
        }
        if Int(self.inputDict["ChildCount"]!)! > 1 {
            childStr = "Children"
        }
        if Int(self.inputDict["InfantCount"]!)! > 1 {
            infantStr = "Infants"
        }
        
//        self.tripPassengerDetailLbl.text = "\(self.inputDict["AdultCount"]!) \(adultStr!),\(self.inputDict["ChildCount"]!) \(childStr!),\(self.inputDict["InfantCount"]!) \(infantStr!)"
        
        
        //New Format
//        self.tripDetailSourceLbl.text = self.inputDict["Origin"]!
//        var passengerStr = "\(self.inputDict["AdultCount"]!) \(adultStr!) "
//
//        if Int(self.inputDict["ChildCount"]!)! != 0 {
//            passengerStr += "\(self.inputDict["ChildCount"]!) \(childStr!) "
//        }
//        if Int(self.inputDict["InfantCount"]!)! != 0 {
//            passengerStr += "\(self.inputDict["InfantCount"]!) \(infantStr!)"
//        }
    
        callSearchFlightService(messageDict: self.inputDict)
    }
    override func viewWillAppear(_ animated: Bool) {
        //        callSearchFlightService(messageDict: self.inputDict)
    }
    
    func callSearchFlightService(messageDict:[String:String]){
        if (Reachability()?.isReachable)! {
            //            self.view.StartLoading()
            showLoading()
            
            /*
             WebService().HTTP_POST_WebServiceMethod_Flight(mainURL: WebServicesUrl.FlightServiceUrl, suffix: WebServicesUrl.FlightResult, parameterDict: messageDict) { (ResponseDict, ResponseStatus) in
             
             hideLoading()
             if ResponseStatus {
             print("Service call success ..........")
             let abc = ResponseDict as! [String:AnyObject]
             print(abc)
             }
             } */
         WebService().HTTP_POST_WebServiceMethod_Flight(mainURL:WebServicesUrl.FlightServiceUrl,suffix: WebServicesUrl.FlightResult, parameterDict: messageDict) { (ResponceDict, success) in
                
                hideLoading()
                if success {
                    print("Service call success ..........")
                    self.filterBtn.isHidden = false
                    
                //                    self.dataTV.isHidden = false
                  //  self.dataTVContainerView.isHidden = false
                    //                print("The ResponseDict finally =",ResponceDict!)
                    
                    let responce = ResponceDict as! [String:AnyObject]
                    //                    if let responce = ResponceDict {
                    self.flightResultArr = responce["FlightResult"] as! [[String:AnyObject]]
                    self.flightDetailsArr = responce["Flightdetails"] as! [[String:AnyObject]]
                    if responce.keys.contains("FlightdetailsReturn"){
                        self.flightDetailsReturnArr = responce["FlightdetailsReturn"] as! [[String : AnyObject]]
                    }
                    
                    self.flightResultAndDetailsArr.removeAll()
                    for aResultDict in self.flightResultArr{
                        var aResultAndDetailStruct = FlightResultAndDetailStruct()
                        
                        aResultAndDetailStruct.wayType = self.way
                        
                        //Flight ID
                        aResultAndDetailStruct.flightID = "\(aResultDict["FlightId"]!)"
                        
                        //Refundable
                        aResultAndDetailStruct.faretype = "\(aResultDict["faretype"]!)"
                        
                        //Amount
                        aResultAndDetailStruct.amount = "\(aResultDict["totalAmountAll"]!)"
                        
                        //Baggage - "CabinBaggage": "&lt;p&gt;7 KG&lt;/p&gt;",
                        //aResultAndDetailStruct.CabinBaggage = "\(aResultDict["CabinBaggage"]!)"
                        if self.way == "one" { // As of now only for one way baggage details data available in backend
                            let tempCabinBagArr = "\(aResultDict["CabinBaggage"]!)".components(separatedBy: ";")
                            let tempCabinBagArr2 = tempCabinBagArr[2].components(separatedBy: "&")
                            aResultAndDetailStruct.CabinBaggage = tempCabinBagArr2[0]
                            
                            //"CheckInBaggage": "&lt;p&gt; 25 KG &lt;/p&gt; ",
                            //aResultAndDetailStruct.CheckInBaggage = "\(aResult["CheckInBaggage"]!)"
                            let tempCheckInBagArr = "\(aResultDict["CheckInBaggage"]!)".components(separatedBy: ";")
                            let tempCheckInBagArr2 = tempCheckInBagArr[2].components(separatedBy: "&")
                            aResultAndDetailStruct.CheckInBaggage = tempCheckInBagArr2[0]
                        }
                        
                        
                        
                        //Flight Details
                        for aDetailDict in self.flightDetailsArr {
                            
                            if "\(aDetailDict["FlightId"]!)" == "\(aResultDict["FlightId"]!)"{
                                var aDetailStruct = FlightDetailStruct()
                                aDetailStruct.flightNumber = "\(aDetailDict["flightNumber"]!)"
                                aDetailStruct.departureDate = "\(aDetailDict["departuredate"]!)"
                                aDetailStruct.departureTime = "\(aDetailDict["departuretime"]!)"
                                aDetailStruct.arrivalDate = "\(aDetailDict["arrivaldate"]!)"
                                aDetailStruct.arrivalTime = "\(aDetailDict["arrivaltime"]!)"
                                
                                aDetailStruct.marketing = "\(aDetailDict["marketing"]!)"
                                aDetailStruct.operating = "\(aDetailDict["operating"]!)"
                                aDetailStruct.duration = "\(aDetailDict["duration"]!)"
                                aDetailStruct.fromAirportName = "\(aDetailDict["FromAirportName"]!)"
                                aDetailStruct.toAirportName = "\(aDetailDict["ToAirportName"]!)"
                                
                                aDetailStruct.departureDateTime = "\(aDetailDict["DepartureDateTime"]!)"
                                aDetailStruct.arrivalDateTime = "\(aDetailDict["ArrivalDateTime"]!)"
                                
                                aDetailStruct.stop = "\(aDetailDict["stop"]!)"
                                aDetailStruct.fromCity = "\(aDetailDict["fromcity"]!)"
                                aDetailStruct.toCity = "\(aDetailDict["tocity"]!)"
                                
                                aResultAndDetailStruct.detailArrWithFlightDetailStruct.append(aDetailStruct)
                            }
                        }
                        
                        //Flight Name
                        if aResultAndDetailStruct.detailArrWithFlightDetailStruct.count > 1 {
                            
                            
                            aResultAndDetailStruct.isMultiAirlineAvailable = false
                            let lastStruct = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last
                            
                            
                            for i in 0..<aResultAndDetailStruct.detailArrWithFlightDetailStruct.count {
                                if i == aResultAndDetailStruct.detailArrWithFlightDetailStruct.count-1 {
                                    print("This is Last Item")
                                }else{
                                    if aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].marketing != lastStruct?.marketing{
                                        aResultAndDetailStruct.isMultiAirlineAvailable = true
                                        break
                                    }
                                }
                            }
                            
                            if aResultAndDetailStruct.isMultiAirlineAvailable{
                                print("Multiple Exists...")
                                aResultAndDetailStruct.flightName = "Multi Airlines"
                                aResultAndDetailStruct.flightImgName = "multiairline"
                            }else{
                                print("Multiple Exists...But All are same")
                                aResultAndDetailStruct.flightName = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last?.operating
                                aResultAndDetailStruct.flightImgName = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last?.marketing
                            }
                            
                            
                            
                        }else if aResultAndDetailStruct.detailArrWithFlightDetailStruct.count == 1 {
                            aResultAndDetailStruct.flightName = aResultAndDetailStruct.detailArrWithFlightDetailStruct[0].operating
                            aResultAndDetailStruct.flightImgName = aResultAndDetailStruct.detailArrWithFlightDetailStruct[0].marketing
                        }else{
                            print("0 flight")
                            aResultAndDetailStruct.flightName = "0 Flight"
                            aResultAndDetailStruct.flightImgName = "No Flight"
                        }
                        
                        //Depature Time
                        aResultAndDetailStruct.departureTime = aResultAndDetailStruct.detailArrWithFlightDetailStruct[0].departureTime
                        
                        //Depature Date
                        let tempDepDateArr = aResultAndDetailStruct.detailArrWithFlightDetailStruct[0].departureDate.components(separatedBy: ",")
                        aResultAndDetailStruct.departureDate = tempDepDateArr[1]
                        
                        
                        
                        //Departure Airport Code
                        //IXM~BLR~BLR~MAA
                        var allAirportCodeArr = "\(aResultDict["dairportall"]!)".components(separatedBy: "~")
                        aResultAndDetailStruct.departureAirportCode = allAirportCodeArr[0]
                        
                        //Duration
                        var sumOfIndividualFlightDurationInSec = 0
                        var layoverArr = [Int]()
                        var start : String!
                        var end : String!
                        
                        for i in 0..<aResultAndDetailStruct.detailArrWithFlightDetailStruct.count {
                            
                            let arr = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].duration.components(separatedBy: ":")
                            let hr = arr[0].trimmingCharacters(in: .whitespaces).dropLast()
                            let min = arr[1].trimmingCharacters(in: .whitespaces).dropLast()
                            
                            let hourSec = Int(hr)! * 3600
                            let minSec = Int(min)! * 60
                            let totalSec = hourSec + minSec
                            
                            sumOfIndividualFlightDurationInSec += totalSec
                            
                            
                            if (i%2) == 0 {  // 0 modulo 2 = 0,     1 modulo 2 = 1 ,    2 modulo 2 = 0
                                if i == 0 {
                                    start = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].arrivalDateTime
                                }else{
                                    end = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].departureDateTime
                                    layoverArr.append(self.calculateSecondsFrom(dateTime1: start, dateTime2: end))
                                    start = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].arrivalDateTime
                                }
                            }else {
                                end = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].departureDateTime
                                layoverArr.append(self.calculateSecondsFrom(dateTime1: start, dateTime2: end))
                                start = aResultAndDetailStruct.detailArrWithFlightDetailStruct[i].arrivalDateTime
                            }
                        }
                        let sumofOverlays = layoverArr.reduce(0, {$0 + $1})
                        let totalDurationInSec = sumOfIndividualFlightDurationInSec + sumofOverlays
                        
                        let numberOfHo: Int = totalDurationInSec / 3600
                        let numberOfMin: Int = (totalDurationInSec % 3600) / 60
                        
                        let durationForForwardFlight = "\(numberOfHo)h \(numberOfMin)m"
                        aResultAndDetailStruct.duration = durationForForwardFlight
                        
                        //Stops
                        if (aResultAndDetailStruct.detailArrWithFlightDetailStruct.count - 1) > 1 {
                            aResultAndDetailStruct.noOfStops = "\(aResultAndDetailStruct.detailArrWithFlightDetailStruct.count - 1) stops"
                        }else{
                            aResultAndDetailStruct.noOfStops = "\(aResultAndDetailStruct.detailArrWithFlightDetailStruct.count - 1) stop"
                        }
                        
                        // Arrival Time
                        aResultAndDetailStruct.arrivalTime = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last?.arrivalTime
                        
                        //Arrival Date
                        let tempArrivalDateArr = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last?.arrivalDate.components(separatedBy: ",")
                        aResultAndDetailStruct.arrivalDate = tempArrivalDateArr![1]
                        
                        // Arrival Airport Code
                        let lastAirportCodeStrForArrival = aResultAndDetailStruct.detailArrWithFlightDetailStruct.last?.toAirportName
                        let startIndexforAirportCode = lastAirportCodeStrForArrival?.index(after: (lastAirportCodeStrForArrival?.lastIndex(of: "("))!)
                        let endIndexforAirportCode = lastAirportCodeStrForArrival?.lastIndex(of: ")")
                        let formattedStrforAirportCode = lastAirportCodeStrForArrival![startIndexforAirportCode!..<endIndexforAirportCode!]
                        //                                print("Result = ",result)
                        aResultAndDetailStruct.arrivalAirportCode = String(formattedStrforAirportCode)
                        
                        // ------ end of oneway ----
                        
                        
                        
                        //Flight Details Return
                        if responce.keys.contains("FlightdetailsReturn"){
                            for aDetailDict in self.flightDetailsReturnArr {
                                if "\(aDetailDict["FlightId"]!)" == "\(aResultDict["FlightId"]!)"{
                                    var aDetailStruct = FlightDetailStruct()
                                    aDetailStruct.flightNumber = "\(aDetailDict["flightNumber"]!)"
                                    aDetailStruct.departureDate = "\(aDetailDict["departuredate"]!)"
                                    aDetailStruct.departureTime = "\(aDetailDict["departuretime"]!)"
                                    aDetailStruct.arrivalDate = "\(aDetailDict["arrivaldate"]!)"
                                    aDetailStruct.arrivalTime = "\(aDetailDict["arrivaltime"]!)"
                                    
                                    aDetailStruct.marketing = "\(aDetailDict["marketing"]!)"
                                    aDetailStruct.operating = "\(aDetailDict["operating"]!)"
                                    aDetailStruct.duration = "\(aDetailDict["duration"]!)"
                                    aDetailStruct.fromAirportName = "\(aDetailDict["FromAirportName"]!)"
                                    aDetailStruct.toAirportName = "\(aDetailDict["ToAirportName"]!)"
                                    
                                    aDetailStruct.departureDateTime = "\(aDetailDict["DepartureDateTime"]!)"
                                    aDetailStruct.arrivalDateTime = "\(aDetailDict["ArrivalDateTime"]!)"
                                    
                                    aDetailStruct.stop = "\(aDetailDict["stop"]!)"
                                    aDetailStruct.fromCity = "\(aDetailDict["fromcity"]!)"
                                    aDetailStruct.toCity = "\(aDetailDict["tocity"]!)"
                                    
                                    aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.append(aDetailStruct)
                                    
                                }
                            }
                        }
                        
                        if self.way == "two" {
                            //Return Flight Name
                            if aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count > 1 {
                                //                                    aResultAndDetailStruct.returnFlightName = "Multi Airlines"
                                
                                
                                
                                aResultAndDetailStruct.isReturnMultiAirlineAvailable = false
                                let lastStructRet = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last
                                
                                for i in 0..<aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count {
                                    if i == aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count-1 {
                                        print("Return This is Last Item")
                                    }else{
                                        if aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].marketing != lastStructRet?.marketing{
                                            aResultAndDetailStruct.isReturnMultiAirlineAvailable = true
                                            break
                                        }
                                    }
                                }
                                
                                if aResultAndDetailStruct.isReturnMultiAirlineAvailable{
                                    print("Return Multiple Exists...")
                                    aResultAndDetailStruct.returnFlightName = "Multi Airlines"
                                    aResultAndDetailStruct.returnFlightImgName = "multiairline"
                                }else{
                                    print("Return Multiple Exists...But All are same")
                                    aResultAndDetailStruct.returnFlightName = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last?.operating
                                    aResultAndDetailStruct.returnFlightImgName = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last?.marketing
                                }
                                
                                
                                
                                
                            }else if aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count == 1 {
                                aResultAndDetailStruct.returnFlightName = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[0].operating
                                aResultAndDetailStruct.returnFlightImgName = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[0].marketing
                            }else{
                                aResultAndDetailStruct.returnFlightName = "0 flight"
                                aResultAndDetailStruct.returnFlightImgName = "No Flight"
                            }
                            
                            
                            
                            
                            
                            
                            //Return Depature Time
                            aResultAndDetailStruct.returnDepartureTime = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.first?.departureTime
                            
                            //Return Depature Date
                            let tempReturnDepDateArr = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.first?.departureDate.components(separatedBy: ",")
                            aResultAndDetailStruct.returnDepartureDate = tempReturnDepDateArr![1]
                            
                            //Return Departure Airport Code
                            let firstAirportCodeStr = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.first?.fromAirportName
                            let startIndReturn = firstAirportCodeStr?.index(after: (firstAirportCodeStr?.lastIndex(of: "(")!)!)
                            let endIndReturn = firstAirportCodeStr?.lastIndex(of: ")")
                            let formattedStrReturn = firstAirportCodeStr![startIndReturn!..<endIndReturn!]
                            aResultAndDetailStruct.returnDepartureAirportCode = String(formattedStrReturn)
                            
                            //Return Duration
                            var sumOfIndividualFlightDurationInSecReturn = 0
                            var layoverArrReturn = [Int]()
                            var startReturn : String!
                            var endReturn : String!
                            
                            for i in 0..<aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count {
                                
                                let arr = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].duration.components(separatedBy: ":")
                                let hr = arr[0].trimmingCharacters(in: .whitespaces).dropLast()
                                let min = arr[1].trimmingCharacters(in: .whitespaces).dropLast()
                                
                                let hourSec = Int(hr)! * 3600
                                let minSec = Int(min)! * 60
                                let totalSec = hourSec + minSec
                                
                                sumOfIndividualFlightDurationInSecReturn += totalSec
                                
                                
                                if (i%2) == 0 {  // 0 modulo 2 = 0,     1 modulo 2 = 1 ,    2 modulo 2 = 0
                                    if i == 0 {
                                        startReturn = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].arrivalDateTime
                                    }else{
                                        endReturn = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].departureDateTime
                                        layoverArrReturn.append(self.calculateSecondsFrom(dateTime1: startReturn, dateTime2: endReturn))
                                        startReturn = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].arrivalDateTime
                                    }
                                }else {
                                    endReturn = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].departureDateTime
                                    layoverArrReturn.append(self.calculateSecondsFrom(dateTime1: startReturn, dateTime2: endReturn))
                                    startReturn = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct[i].arrivalDateTime
                                }
                            }
                            
                            let sumofOverlaysReturn = layoverArrReturn.reduce(0, {$0 + $1})
                            
                            
                            let totalDurationInSecReturn = sumOfIndividualFlightDurationInSecReturn + sumofOverlaysReturn
                            
                            let numberOfHoReturn: Int = totalDurationInSecReturn / 3600
                            let numberOfMinReturn: Int = (totalDurationInSecReturn % 3600) / 60
                            let durationForReturnFlight = "\(numberOfHoReturn)h \(numberOfMinReturn)m"
                            aResultAndDetailStruct.returnDuration = durationForReturnFlight
                            
                            //Return stop
                            if (aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count - 1) > 1 {
                                aResultAndDetailStruct.returnNoofStops = "\(aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count - 1) stops"
                            }else{
                                aResultAndDetailStruct.returnNoofStops = "\(aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.count - 1) stop"
                            }
                            
                            //Return Arrival Time
                            aResultAndDetailStruct.returnArrivalTime = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last?.arrivalTime
                            
                            //Return Arrival Date
                            let tempReturnArrDateArr = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last?.arrivalDate.components(separatedBy: ",")
                            aResultAndDetailStruct.returnArrivalDate = tempReturnArrDateArr![1]
                            
                            
                            //Return Arrival Airport Code
                            let lastAirportCodeStrForReturnArrival = aResultAndDetailStruct.returnDetailArrWithFlightDetailStruct.last?.toAirportName
                            let startIndexforAirportCode = lastAirportCodeStrForReturnArrival?.index(after: (lastAirportCodeStrForReturnArrival?.lastIndex(of: "("))!)
                            let endIndexforAirportCode = lastAirportCodeStrForReturnArrival?.lastIndex(of: ")")
                            let formattedStrforAirportCode = lastAirportCodeStrForReturnArrival![startIndexforAirportCode!..<endIndexforAirportCode!]
                            aResultAndDetailStruct.returnArrivalAirportCode = String(formattedStrforAirportCode)
                        }
                        
                        self.flightResultAndDetailsArr.append(aResultAndDetailStruct)
                    }
                    self.arrToDisplay = self.flightResultAndDetailsArr
                    self.dataTV.reloadData()
                    print("flightResultAndDetailsArr count :",self.flightResultAndDetailsArr.count)
                    //                    }
                    
                }
                else {
                    

                    
                    
                    
           
                    
                    print("No Data for your Search!!! or No Data from Backend!!!")
                    //                    self.dataTV.isHidden = true
                   // self.dataTVContainerView.isHidden = true
                    self.errorLbl.text = "No Data for your Search!!! or No Data from Backend!!!"
                    self.filterBtn.isHidden = true
                }
            }
            
            
            
            
            
            
        }else{
            print("No Internet......")
            //            self.dataTV.isHidden = true
         //   self.dataTVContainerView.isHidden = true
            self.errorLbl.text = "Internet connetivity Problem!!!"
        }
    }
    
    var canAdd : Bool = false
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        //        self.filterBtn.isSelected = true
        flightResultAndDetailArrForFilterVC.removeAll()
        
        if self.way == "one"{
            if self.flightResultAndDetailsArr.count > 0{
                
                if self.flightResultAndDetailsArr[0].flightName != "Multi Airlines" {
                    flightResultAndDetailArrForFilterVC.append(self.flightResultAndDetailsArr[0])
                    print("Added initially :",self.flightResultAndDetailsArr[0].flightName)
                }
                
                for i in 0..<self.flightResultAndDetailsArr.count{
                    for j in 0..<flightResultAndDetailArrForFilterVC.count{
                        if flightResultAndDetailArrForFilterVC[j].flightName != self.flightResultAndDetailsArr[i].flightName{
                            self.canAdd = true
                        }else{
                            self.canAdd = false
                            break
                        }
                    }
                    if canAdd{
                        if self.flightResultAndDetailsArr[i].flightName != "Multi Airlines" {
                            flightResultAndDetailArrForFilterVC.append(self.flightResultAndDetailsArr[i])
                            print("Added :",self.flightResultAndDetailsArr[i].flightName)
                            
                            self.canAdd = false
                        }else{
                            //                            print("This is Multi airlines.So not added.....")
                        }
                    }else{
                        //                        print("Not added : count=",i)
                    }
                }
                print("arrofStruct To Filter count =",flightResultAndDetailArrForFilterVC.count)
                
            }
        }
            //Two way
        else{
            
        }
        
        
        
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FlightFilterVCGoomoSBID") as! FlightFilterVCGoomo
        ctrl.delegateVariable = self
        ctrl.uniqueFlightResultAndDetailArrBasedOnFlightName = flightResultAndDetailArrForFilterVC
        //        self.navigationController?.present(ctrl, animated: true, completion: nil)
        self.navigationController?.pushViewController(ctrl, animated: false)
    }
    @IBAction func departureBtnTapped(_ sender: UIButton) {
        
        flightBtnImgView.image = .none
        priceBtnImgView.image = nil
        
        flightBtn.isSelected = false
        priceBtn.isSelected = false
        
        /*
         if filterBtn.isSelected {
         arrToSort = self.filteredArr
         }else{
         arrToSort = self.flightResultAndDetailsArr
         } */
        
        arrToSort = arrToDisplay
        
        if !sender.isSelected { //isSelected : default is NO..Though if u tap on btn,isSelected value will be NO.We have to set.
            departureBtnImgView.image = UIImage.init(named: "downArrowGreen")
            sender.isSelected = true
            
            self.arrToSort.sort { (firstStruct, secondStruct) -> Bool in
                
                let arr = firstStruct.departureTime?.components(separatedBy: ":")
                let hoursOfFirstStruct = arr![0].trimmingCharacters(in: .whitespaces)
                let minutesOfFirstStruct = arr![1].trimmingCharacters(in: .whitespaces)
                let totalSecOfFirstStruct = (Int(hoursOfFirstStruct)! * 3600) + (Int(minutesOfFirstStruct)! * 60)
                
                let arr2 = secondStruct.departureTime?.components(separatedBy: ":")
                let hoursOfSecondStruct = arr2![0].trimmingCharacters(in: .whitespaces)
                let minutesOfSecondStruct = arr2![1].trimmingCharacters(in: .whitespaces)
                let totalSecOfSecondStruct = (Int(hoursOfSecondStruct)! * 3600) + (Int(minutesOfSecondStruct)! * 60)
                
                return totalSecOfFirstStruct > totalSecOfSecondStruct
            }
        }else{
            departureBtnImgView.image = UIImage.init(named: "upArrowGreen")
            sender.isSelected = false
            
            self.arrToSort.sort { (firstStruct, secondStruct) -> Bool in
                
                let arr = firstStruct.departureTime?.components(separatedBy: ":")
                let hoursOfFirstStruct = arr![0].trimmingCharacters(in: .whitespaces)
                let minutesOfFirstStruct = arr![1].trimmingCharacters(in: .whitespaces)
                let totalSecOfFirstStruct = (Int(hoursOfFirstStruct)! * 3600) + (Int(minutesOfFirstStruct)! * 60)
                
                let arr2 = secondStruct.departureTime?.components(separatedBy: ":")
                let hoursOfSecondStruct = arr2![0].trimmingCharacters(in: .whitespaces)
                let minutesOfSecondStruct = arr2![1].trimmingCharacters(in: .whitespaces)
                let totalSecOfSecondStruct = (Int(hoursOfSecondStruct)! * 3600) + (Int(minutesOfSecondStruct)! * 60)
                
                return totalSecOfFirstStruct < totalSecOfSecondStruct
            }
        }
        self.arrToDisplay = self.arrToSort
        dataTV.reloadData()
    }
    
    
    @IBAction func flightNameBtnTapped(_ sender: UIButton) {
        departureBtnImgView.image = nil
        priceBtnImgView.image = .none
        
        departureBtn.isSelected = false
        priceBtn.isSelected = false
        
        /*
         if filterBtn.isSelected {
         arrToSort = self.filteredArr
         }else{
         arrToSort = self.flightResultAndDetailsArr
         }*/
        arrToSort = arrToDisplay
        
        if !sender.isSelected {
            flightBtnImgView.image = UIImage.init(named: "downArrowGreen")
            sender.isSelected = true
            self.arrToSort.sort { (abc, xyz) -> Bool in
                return  abc.flightName > xyz.flightName
            }
        }else{
            flightBtnImgView.image = UIImage.init(named: "upArrowGreen")
            sender.isSelected = false
            self.arrToSort.sort { (abc, xyz) -> Bool in
                return  abc.flightName < xyz.flightName
            }
        }
        self.arrToDisplay = self.arrToSort
        dataTV.reloadData()
    }
    @IBAction func priceBtnTapped(_ sender: UIButton) {
        departureBtnImgView.image = nil
        flightBtnImgView.image = .none
        
        departureBtn.isSelected = false
        flightBtn.isSelected = false
        
        
        /*
         if filterBtn.isSelected {
         arrToSort = self.filteredArr
         }else{
         arrToSort = self.flightResultAndDetailsArr
         }*/
        arrToSort = arrToDisplay
        
        if !sender.isSelected {
            priceBtnImgView.image = UIImage.init(named: "downArrowGreen")
            sender.isSelected = true
            //            self.flightResultAndDetailsArr.sort { $0.amount.I > $1.Int(amount)}
            
            self.arrToSort.sort { (abc, xyz) -> Bool in
                
                let amount0Int : Int = Int(abc.amount)!
                let amount1Int : Int = Int(xyz.amount)!
                return amount0Int > amount1Int
            }
        }else{
            priceBtnImgView.image = UIImage.init(named: "upArrowGreen")
            sender.isSelected = false
            //            self.flightResultAndDetailsArr.sort { Int($0.amount) < Int($1.amount)}
            self.arrToSort.sort { (efg, hij) -> Bool in
                let amount0Int : Int = Int(efg.amount)!
                let amount1Int : Int = Int(hij.amount)!
                return amount0Int < amount1Int
            }
        }
        self.arrToDisplay = self.arrToSort
        dataTV.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     func calculateHoursAndMinsFrom(dateTime1 : String,dateTime2 : String) -> (hours : String,minutes : String){
     let deptDate : Date? = dateFormatter.date(from: dateTime1)
     let arrivalDate : Date? = dateFormatter.date(from: dateTime2)
     
     var secondsBetween: TimeInterval? = nil
     if let aDate = deptDate {
     secondsBetween = arrivalDate?.timeIntervalSince(aDate)
     }
     let seconds = Int(secondsBetween ?? 0) // Since modulo operator (%) below needs int or long
     let numberOfHours: Int = seconds / 3600
     let numberOfMinutes: Int = (seconds % 3600) / 60
     
     //        let duration = "\(numberOfHours)h \(numberOfMinutes)m"
     
     return("\(numberOfHours)","\(numberOfMinutes)")
     }*/
    
    func calculateSecondsFrom(dateTime1 : String,dateTime2 : String) -> (Int){
        let deptDate : Date? = dateFormatter.date(from: dateTime1)
        let arrivalDate : Date? = dateFormatter.date(from: dateTime2)
        
        var secondsBetween: TimeInterval? = nil
        if let aDate = deptDate {
            secondsBetween = arrivalDate?.timeIntervalSince(aDate)
        }
        let seconds = Int(secondsBetween ?? 0) // Since modulo operator (%) below needs int or long
        return seconds
    }
}
extension FlightResultVCGoomo : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         if self.filterBtn.isSelected {
         return self.filteredArr.count
         }else{
         return self.flightResultAndDetailsArr.count
         } */
        return self.arrToDisplay.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if self.inputDict["WayType"]! == "two"
       {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! onewayTableViewCell
        
        let flightImgURL = WebServicesUrl.FlightImgURL + self.arrToDisplay[indexPath.row].detailArrWithFlightDetailStruct[0].marketing + ".gif"
    
        if self.arrToDisplay[indexPath.row].flightImgName == "multiairline" {
            cell.flightImg.image = UIImage(named: "multiairline")
            cell.flightName.text = self.arrToDisplay[indexPath.row].flightName
     
            cell.flightName.text = self.arrToDisplay[indexPath.row].detailArrWithFlightDetailStruct[0].operating
            
            if self.arrToDisplay[indexPath.row].flightImgData != nil {
                cell.flightImg.image = UIImage(data: self.arrToDisplay[indexPath.row].flightImgData!)
            }else{
                cell.flightImg.sd_setShowActivityIndicatorView(true)
                cell.flightImg.sd_setIndicatorStyle(.gray)
                cell.flightImg.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "flightGreen"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                    if error == nil{
                        self.arrToDisplay[indexPath.row].flightImgData = downloadedImage!.pngData()
                    }else{
                        print("Error from SBWebImage Block = ",error!)
                    }
                    
                })
                
                
            }
            
        }
        cell.departTime.text = self.arrToDisplay[indexPath.row].departureTime.appending(" - ") .appending(self.arrToDisplay[indexPath.row].arrivalTime)
        cell.departCode.text = self.arrToDisplay[indexPath.row].departureAirportCode
        cell.duration.text = self.arrToDisplay[indexPath.row].duration
        cell.stop.text = self.arrToDisplay[indexPath.row].noOfStops
        
        cell.amount.lineBreakMode = .byWordWrapping
        
        let fStr = NSMutableAttributedString()
        let attribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let xyz = NSAttributedString(string: self.arrToDisplay[indexPath.row].amount,attributes:attribute1)
        
        let attribute2 = [NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "#338EDF"),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        //        var abc = NSAttributedString(string: "MYR",attributes:)
        let abc = NSAttributedString(string: "MYR", attributes: attribute2)
        
        fStr.append(abc)
        fStr.append(NSAttributedString(string: "\n"))
        fStr.append(xyz)
        cell.amount.attributedText = fStr
        
        return cell
        
       }
//Return - Twoway
       else
       {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! twowayTableViewCell
        let flightImgURL = WebServicesUrl.FlightImgURL + self.arrToDisplay[indexPath.row].detailArrWithFlightDetailStruct[0].marketing + ".gif"
        /* or
         let flightImgURL = WebServicesUrl.FlightImgURL + self.flightResultAndDetailsArr[indexPath.row].flightImgName */
        
        if self.arrToDisplay[indexPath.row].flightImgName == "multiairline" {
            cell.flightImg.image = UIImage(named: "multiairline")
            cell.flightName.text = self.arrToDisplay[indexPath.row].flightName
            //            self.arrToDisplay[indexPath.row].flightImgData = UIImage(named: "multiairline")!.pngData(UIImage(named: "multiairline")!.pngDatan
            
            cell.flightName.text = self.arrToDisplay[indexPath.row].detailArrWithFlightDetailStruct[0].operating
            
            if self.arrToDisplay[indexPath.row].flightImgData != nil {
                cell.flightImg.image = UIImage(data: self.arrToDisplay[indexPath.row].flightImgData!)
            }else{
                cell.flightImg.sd_setShowActivityIndicatorView(true)
                cell.flightImg.sd_setIndicatorStyle(.gray)
                cell.flightImg.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "flightGreen"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                    if error == nil{
                        self.arrToDisplay[indexPath.row].flightImgData = downloadedImage!.pngData()
                    }else{
                        print("Error from SBWebImage Block = ",error!)
                    }
                    
                })
                
                
            }
            
        }
        
        
        cell.departTime.text = self.arrToDisplay[indexPath.row].departureTime .appending(self.arrToDisplay[indexPath.row].arrivalTime)
        cell.lblRefundable.text = self.arrToDisplay[indexPath.row].departureAirportCode
        cell.duration.text = self.arrToDisplay[indexPath.row].duration.appending(" - ").appending(self.arrToDisplay[indexPath.row].noOfStops)
       // cell.stop.text = self.arrToDisplay[indexPath.row].noOfStops
        
        cell.amount.lineBreakMode = .byWordWrapping
        
        let fStr = NSMutableAttributedString()
        let attribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let xyz = NSAttributedString(string: self.arrToDisplay[indexPath.row].amount,attributes:attribute1)
        
        let attribute2 = [NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "#338EDF"),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        //        var abc = NSAttributedString(string: "MYR",attributes:)
        let abc = NSAttributedString(string: "MYR", attributes: attribute2)
        
        fStr.append(abc)
        fStr.append(NSAttributedString(string: "\n"))
        fStr.append(xyz)
        cell.amount.attributedText = fStr
        
        return cell
        }
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var structToSend : FlightResultAndDetailStruct!
        
        /*
         if self.filterBtn.isSelected {
         structToSend = self.filteredArr[indexPath.row]
         }else{
         structToSend = self.flightResultAndDetailsArr[indexPath.row]
         } */
        structToSend = self.arrToDisplay[indexPath.row]
        
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FlightReviewVCGoomoSBID") as! FlightReviewVCGoomo
        ctrl.providedInputDict = self.inputDict
        ctrl.selectedStruct = structToSend
        self.navigationController?.pushViewController(ctrl, animated: true)
    
    }
}
 func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
{
    // 1
    let shareAction = UITableViewRowAction(style: .default, title: "Detail" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
        // 2
      
    })
    // 3
    let rateAction = UITableViewRowAction(style: .default, title: "Rate" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
        // 4
     
    })
    // 5
    return [shareAction,rateAction]
}
class OnewayCellClassGoomo : UITableViewCell {
    
    @IBOutlet weak var flightImgView: UIImageView!
    @IBOutlet weak var flightNameLbl: UILabel!
    @IBOutlet weak var depTimeLbl: UILabel!
    @IBOutlet weak var depAirportCodeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var stopDetailsLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    @IBOutlet weak var arrivalAirportCodeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var depDateLbl: UILabel!
    @IBOutlet weak var arrDateLbl: UILabel!
    @IBOutlet weak var classTypeLbl: UILabel!
    @IBOutlet weak var refundOrNonRefundLbl: UILabel!
    @IBOutlet weak var lineDesignVIew: UIView!
    @IBOutlet weak var returnFlightLbl: UILabel!
    
}

//MARK: - FlightFliterDelegateGoomo {
extension FlightResultVCGoomo : FlightFilterDelegateGoomo {
    func didBackBtnTapped(filterBtnTappedFlag: Bool, controller: FlightFilterVCGoomo) {
        //        self.filterBtn.isSelected = filterBtnTappedFlag
        controller.navigationController?.popViewController(animated: true)
    }
    func didApplyBtnTapped(userSelectedFilterStruct: FlightUserSelectedFiltersStruct, controller: FlightFilterVCGoomo) {
        controller.navigationController?.popViewController(animated: true)
        //        print(userSelectedFilterStruct)
     
        
        self.filteredArr = self.flightResultAndDetailsArr.filter { (aStruct) -> Bool in
            
            var returnStatus : Bool!
            if userSelectedFilterStruct.isNonStop && userSelectedFilterStruct.isOneStop && userSelectedFilterStruct.isTwoPlusStops {
                returnStatus = true //return true
            }else if userSelectedFilterStruct.isNonStop && userSelectedFilterStruct.isOneStop {
                if aStruct.noOfStops == "0 stop" || aStruct.noOfStops == "1 stop" {
                    returnStatus = true //return true
                }else{
                    returnStatus = false //return false
                }
            }else if userSelectedFilterStruct.isNonStop && userSelectedFilterStruct.isTwoPlusStops {
                if aStruct.noOfStops != "1 stop"{
                    returnStatus = true //return true
                }else{
                    returnStatus = false //return false
                }
            }else if userSelectedFilterStruct.isOneStop && userSelectedFilterStruct.isTwoPlusStops {
                if aStruct.noOfStops != "0 stop"{
                    returnStatus = true //return true
                }else{
                    returnStatus = false //return false
                }
            }else if userSelectedFilterStruct.isNonStop {
                if aStruct.noOfStops == "0 stop" {
                    returnStatus = true
                }else{
                    returnStatus = false
                }
                
            }else if userSelectedFilterStruct.isOneStop {
                if aStruct.noOfStops == "1 stop" {
                    returnStatus = true
                }else{
                    returnStatus = false
                }
                
            }else if userSelectedFilterStruct.isTwoPlusStops{
                if aStruct.noOfStops != "0 stop" && aStruct.noOfStops != "1 stop"  {
                    returnStatus = true
                }else{
                    returnStatus = false
                }
            }
            else{
                returnStatus = true
            }
            
            if returnStatus {
                
                let arr = aStruct.departureTime?.components(separatedBy: ":")
                let hoursOfCurrentStruct = arr![0].trimmingCharacters(in: .whitespaces)
                let minutesOfCurrentStruct = arr![1].trimmingCharacters(in: .whitespaces)
                let totalSecOfCurrentStruct = (Int(hoursOfCurrentStruct)! * 3600) + (Int(minutesOfCurrentStruct)! * 60)
                
                //ABCD
                if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.fivePMToNinePM && userSelectedFilterStruct.afterNinePM {
                    returnStatus = true
                }
                    //ABC
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.fivePMToNinePM {
                    
                    let mostSecOfFilterStruct = (21 * 3600)
                    
                    if totalSecOfCurrentStruct <= mostSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //ABD
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.afterNinePM {
                    
                    let mostSecOfFilterStruct1 = (17 * 3600)
                    
                    let leastSecOfFilterStruct2 = (21 * 3600)
                    
                    if (totalSecOfCurrentStruct <= mostSecOfFilterStruct1) || (totalSecOfCurrentStruct >= leastSecOfFilterStruct2){
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                    
                }
                    //ACD
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.fivePMToNinePM && userSelectedFilterStruct.afterNinePM {
                    
                    let mostSecOfFilterStruct1 = (11 * 3600)
                    
                    let leastSecOfFilterStruct2 = (17 * 3600)
                    
                    if (totalSecOfCurrentStruct <= mostSecOfFilterStruct1) || (totalSecOfCurrentStruct >= leastSecOfFilterStruct2){
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                    
                }
                    //BCD
                else if userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.fivePMToNinePM && userSelectedFilterStruct.afterNinePM {
                    
                    let leastSecOfFilterStruct1 = (11 * 3600)
                    
                    if (totalSecOfCurrentStruct >= leastSecOfFilterStruct1) {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //AB
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.elevenAMToFivePM {
                    
                    let totalSecOfFilterStruct = (17 * 3600)
                    
                    if totalSecOfCurrentStruct <= totalSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //AC
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.fivePMToNinePM {
                    
                    let leastSecOfFilterStruct1 = (11 * 3600)
                    
                    let leastSecOfFilterStruct2 = (17 * 3600)
                    let mostSecOfFilterStruct2 =  (21 * 3600)
                    
                    if totalSecOfCurrentStruct <= leastSecOfFilterStruct1 || (totalSecOfCurrentStruct >= leastSecOfFilterStruct2 && totalSecOfCurrentStruct <= mostSecOfFilterStruct2) {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //AD
                else if userSelectedFilterStruct.beforeElevenAM && userSelectedFilterStruct.afterNinePM {
                    let leastSecOfFilterStruct1 = (11 * 3600)
                    
                    let leastSecOfFilterStruct2 = (21 * 3600)
                    let mostSecOfFilterStruct2 =  (24 * 3600)
                    
                    if totalSecOfCurrentStruct <= leastSecOfFilterStruct1 || (totalSecOfCurrentStruct >= leastSecOfFilterStruct2 && totalSecOfCurrentStruct <= mostSecOfFilterStruct2) {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //BC
                else if userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.fivePMToNinePM {
                    
                    let leastSecOfFilterStruct = (11 * 3600)
                    let mostSecOfFilterStruct =  (21 * 3600)
                    
                    if totalSecOfCurrentStruct >= leastSecOfFilterStruct && totalSecOfCurrentStruct <= mostSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    
                    //BD
                else if userSelectedFilterStruct.elevenAMToFivePM && userSelectedFilterStruct.afterNinePM {
                    
                    let leastSecOfFilterStruct1 = (11 * 3600)
                    let mostSecOfFilterStruct1 = (17 * 3600)
                    
                    let leastSecOfFilterStruct2 = (21 * 3600)
                    let mostSecOfFilterStruct2 =  (24 * 3600)
                    
                    if (totalSecOfCurrentStruct >= leastSecOfFilterStruct1 && totalSecOfCurrentStruct <= mostSecOfFilterStruct1) || (totalSecOfCurrentStruct >= leastSecOfFilterStruct2 && totalSecOfCurrentStruct <= mostSecOfFilterStruct2) {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //CD
                else if userSelectedFilterStruct.fivePMToNinePM && userSelectedFilterStruct.afterNinePM {
                    
                    let leastSecOfFilterStruct = (17 * 3600)
                    //                    let mostSecOfFilterStruct =  (24 * 3600)
                    
                    if totalSecOfCurrentStruct >= leastSecOfFilterStruct  {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //A
                else if userSelectedFilterStruct.beforeElevenAM {
                    
                    let totalSecOfFilterStruct = (11 * 3600)
                    
                    if totalSecOfCurrentStruct <= totalSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //B
                else if userSelectedFilterStruct.elevenAMToFivePM {
                    let leastSecOfFilterStruct = (11 * 3600)
                    let mostSecOfFilterStruct =  (17 * 3600)
                    
                    if totalSecOfCurrentStruct >= leastSecOfFilterStruct && totalSecOfCurrentStruct <= mostSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //C
                else if userSelectedFilterStruct.fivePMToNinePM {
                    
                    let leastSecOfFilterStruct = (17 * 3600)
                    let mostSecOfFilterStruct =  (21 * 3600)
                    
                    if totalSecOfCurrentStruct >= leastSecOfFilterStruct && totalSecOfCurrentStruct <= mostSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }
                    //D
                else if userSelectedFilterStruct.afterNinePM {
                    
                    let leastSecOfFilterStruct = (21 * 3600)
                    //                    let mostSecOfFilterStruct =  (24 * 3600)
                    
                    if totalSecOfCurrentStruct >= leastSecOfFilterStruct {
                        returnStatus = true
                    }else{
                        returnStatus = false
                    }
                }else{
                    returnStatus = true
                }
                
                
                if returnStatus {
                    for aString in userSelectedFilterStruct.preferredAirlinesArr{
                        if aStruct.flightName == aString {
                            returnStatus = true
                            break
                        }else{
                            returnStatus = false
                        }
                    }
                    
                    if returnStatus {
                        return true
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            }else{
                return false
            }
        }
        print("Filtered Arr Count :",self.filteredArr.count)
        self.arrToDisplay = self.filteredArr
        self.dataTV.reloadData()
        if self.filteredArr.count == 0 {
           
           // self.dataTVContainerView.isHidden = true
            self.errorLbl.text = "No Result for your filter!!!"
        }else{
          //  self.dataTVContainerView.isHidden = false
        }
        
    }
} 
//MARK: - }
