//
//  FlightReviewVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 14/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SDWebImage

class FlightReviewVCGoomo: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var txtTotalAmt: UILabel!
    @IBOutlet weak var lblTaxAmt: UILabel!
    @IBOutlet weak var lblFareAmount: UILabel!
    @IBOutlet var bottomView: UIView!
    var selectedStruct : FlightResultAndDetailStruct!
    var providedInputDict = [String:String]()
    
    @IBOutlet weak var tripDetaillbl: UILabel!
    @IBOutlet weak var tvContainerView: UIView!
    @IBOutlet weak var myTV: UITableView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    var detailsArr = [FlightDetailStruct]()
    var returnDetailsArr = [FlightDetailStruct]()
    
    var myArray : [FinalStruct?]?
    var myArray1 : [FinalStruct?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if FetchLoginDetails() != nil {
//            self.continueBtn.isHidden = false
//        }else{
//            self.continueBtn.isHidden = true
//        }
       
        tripDetaillbl.text = UserDefaults .standard .value(forKey: "toplbl") as! String
        print("selected Struct = ",self.selectedStruct)
        self.lblFareAmount.text = "PHP " + self.selectedStruct.amount
        self.txtTotalAmt.text = "PHP " + self.selectedStruct.amount
        
        let fStr = NSMutableAttributedString()
        let attribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let xyz = NSAttributedString(string: self.selectedStruct.amount,attributes:attribute1)
        
        let attribute2 = [NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "#338EDF"),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let abc = NSAttributedString(string: "PHP ", attributes: attribute2)
        
        fStr.append(abc)
        //        fStr.append(NSAttributedString(string: "\n"))
        fStr.append(xyz)
       // self.amountLbl.attributedText = fStr
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.detailsArr = selectedStruct.detailArrWithFlightDetailStruct
        let detailStructFinal =  FinalStruct.init(CabinBaggage: selectedStruct.CabinBaggage, CheckInBaggage: selectedStruct.CheckInBaggage, departureDate: selectedStruct.departureDate, arrivalDate: selectedStruct.arrivalDate,flightImgName:selectedStruct.flightImgName,flightImgData:selectedStruct.flightImgData, flightName: selectedStruct.flightName, departureTime: selectedStruct.departureTime, departureAirportCode: selectedStruct.departureAirportCode, duration: selectedStruct.duration, stop: selectedStruct.noOfStops, arrivalTime: selectedStruct.arrivalTime, arrivalAirportCode: selectedStruct.arrivalAirportCode,TripDetailsArr: detailsArr)
        
        self.myArray = [detailStructFinal]
        if selectedStruct.wayType == "two" {
            
            self.returnDetailsArr = selectedStruct.returnDetailArrWithFlightDetailStruct
            let returnDetailStructFinal = FinalStruct.init(CabinBaggage: "Nothing from DB", CheckInBaggage: "Nothing from DB",departureDate:selectedStruct.returnDepartureDate,arrivalDate:selectedStruct.returnArrivalDate,flightImgName:selectedStruct.returnFlightImgName,flightImgData:nil, flightName: selectedStruct.returnFlightName, departureTime: selectedStruct.returnDepartureTime, departureAirportCode: selectedStruct.returnDepartureAirportCode, duration: selectedStruct.returnDuration, stop: selectedStruct.returnNoofStops, arrivalTime: selectedStruct.returnArrivalTime, arrivalAirportCode: selectedStruct.returnArrivalAirportCode,TripDetailsArr: returnDetailsArr)
            
          //  self.myArray?.append(returnDetailStructFinal)
           self.myArray1 = [returnDetailStructFinal]
        }
        self.myTV.delegate = self
        self.myTV.dataSource = self
       print("detailC",self.detailsArr)
        print("ReturndetailC",self.returnDetailsArr)
        
        self.myTV.tableFooterView = bottomView
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueAsGuestBtnTapped(_ sender: UIButton) {
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "TravellerDetailVCGoomoSBID") as! TravellerDetailVCGoomo
        ctrl.selectedStruct = self.selectedStruct
        ctrl.providedInputDict = self.providedInputDict
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "TravellerDetailVCGoomoSBID") as! TravellerDetailVCGoomo
        ctrl.selectedStruct = self.selectedStruct
        ctrl.providedInputDict = self.providedInputDict
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageVCGoomoSBID") as! LoginPageVCGoomo
        ctrl.loginFrom = "FlightReview"
        ctrl.delegateVariable = self
        self.navigationController?.pushViewController(ctrl, animated: true)
        //        self.navigationController?.present(ctrl, animated: true, completion: nil)
    }

}
extension FlightReviewVCGoomo : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedStruct.wayType == "one" {
            return 1
        }
        else
        {
            return  2
        }
    }
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let result = tableView.dequeueReusableCell(withIdentifier: "MainCellIDGoomo") as! MainCellClassGoomo
     
      if(section == 0)
      {
        if let rowData = myArray?[0] {
            result.depAirportCodeLbl.text = rowData.departureAirportCode + " -> " + rowData.arrivalAirportCode
            result.stopDetailsLbl.text = rowData.stop
            result.departureDateLbl.text = rowData.departureDate + "," + rowData.arrivalDate
            return result
        }
    }
      else if(section == 1){
        if let rowData = myArray1?[0]
        {
            result.depAirportCodeLbl.text = rowData.departureAirportCode + " -> " + rowData.arrivalAirportCode
            result.stopDetailsLbl.text = rowData.stop
            result.departureDateLbl.text = rowData.departureDate + " - " + rowData.arrivalDate
            return result
        }
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(section == 0)
       {
        return self.detailsArr.count
    }
        else
       {
        return self.returnDetailsArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = tableView.dequeueReusableCell(withIdentifier: "SubCellIDGoomo", for: indexPath) as! SubCellClassGoomo
        if (indexPath.section == 0)
        {
            result.flightNameLbl.text = self.detailsArr [indexPath.row].operating
            result.depAirportCodeLbl.text = self.detailsArr [indexPath.row].fromAirportName
            result.stopDetailsLbl.text = self.detailsArr [indexPath.row].marketing
            result.arrivalAirportCodeLbl.text = self.detailsArr [indexPath.row].toAirportName
            result.departureDateLbl.text = self.detailsArr [indexPath.row].departureDate
            result.arrivalDateLbl.text = self.detailsArr [indexPath.row].arrivalDate
          
            
            result.depTimeLbl.text = self.detailsArr [indexPath.row].departureTime
            let tempfromAirportCodeStr = self.detailsArr [indexPath.row].fromAirportName
            let startInd = tempfromAirportCodeStr?.index(after: (tempfromAirportCodeStr?.lastIndex(of: "("))!)
            let endInd = tempfromAirportCodeStr?.lastIndex(of: ")")
            let formattedFromStr = tempfromAirportCodeStr![startInd!..<endInd!]
            result.depAirportCodeLbl.text = String(formattedFromStr)
    
            result.durationLbl.text = self.detailsArr [indexPath.row].duration
            result.stopDetailsLbl.text = self.detailsArr [indexPath.row].stop
            result.arrivalTimeLbl.text = self.detailsArr [indexPath.row].arrivalTime
       
            let tempToAirportCodeStr = self.detailsArr [indexPath.row].toAirportName
            let startInde = tempToAirportCodeStr?.index(after: (tempToAirportCodeStr?.lastIndex(of: "("))!)
            let endInde = tempToAirportCodeStr?.lastIndex(of: ")")
            let formattedToStr = tempToAirportCodeStr![startInde!..<endInde!]
            result.arrivalAirportCodeLbl.text = String(formattedToStr)
            
            let tempDepDateArr = self.detailsArr [indexPath.row].departureDate.components(separatedBy: ",")
            result.departureDateLbl.text = tempDepDateArr[1]
            let tempArrivalDateArr = self.detailsArr [indexPath.row].arrivalDate.components(separatedBy: ",")
            result.arrivalDateLbl.text = tempArrivalDateArr[1]

            
            //Image
            let flightImgURL = WebServicesUrl.FlightImgURL + self.detailsArr [indexPath.row].marketing + ".gif"
            result.flightImgView.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                if error == nil{
                    print("Image downloaded without error......")
                }else{
                    print("Error from SBWebImage Block = ",error!)
                }
                
            })

            return result
        }
        else if (indexPath.section == 1)
        {
            result.flightNameLbl.text = self.returnDetailsArr [indexPath.row].operating
            result.depAirportCodeLbl.text = self.returnDetailsArr [indexPath.row].fromAirportName
            result.stopDetailsLbl.text = self.returnDetailsArr [indexPath.row].marketing
            result.arrivalAirportCodeLbl.text = self.returnDetailsArr [indexPath.row].toAirportName
            result.departureDateLbl.text = self.returnDetailsArr [indexPath.row].departureDate
            result.arrivalDateLbl.text = self.returnDetailsArr [indexPath.row].arrivalDate
            
            result.depTimeLbl.text = self.returnDetailsArr [indexPath.row].departureTime
            let tempfromAirportCodeStr = self.returnDetailsArr [indexPath.row].fromAirportName
            let startInd = tempfromAirportCodeStr?.index(after: (tempfromAirportCodeStr?.lastIndex(of: "("))!)
            let endInd = tempfromAirportCodeStr?.lastIndex(of: ")")
            let formattedFromStr = tempfromAirportCodeStr![startInd!..<endInd!]
            result.depAirportCodeLbl.text = String(formattedFromStr)
            
            result.durationLbl.text = self.returnDetailsArr [indexPath.row].duration
            result.stopDetailsLbl.text = self.returnDetailsArr [indexPath.row].stop
            result.arrivalTimeLbl.text = self.returnDetailsArr [indexPath.row].arrivalTime
            
            let tempToAirportCodeStr = self.returnDetailsArr [indexPath.row].toAirportName
            let startInde = tempToAirportCodeStr?.index(after: (tempToAirportCodeStr?.lastIndex(of: "("))!)
            let endInde = tempToAirportCodeStr?.lastIndex(of: ")")
            let formattedToStr = tempToAirportCodeStr![startInde!..<endInde!]
            result.arrivalAirportCodeLbl.text = String(formattedToStr)
            
            let tempDepDateArr = self.returnDetailsArr [indexPath.row].departureDate.components(separatedBy: ",")
            result.departureDateLbl.text = tempDepDateArr[1]
            let tempArrivalDateArr = self.returnDetailsArr [indexPath.row].arrivalDate.components(separatedBy: ",")
            result.arrivalDateLbl.text = tempArrivalDateArr[1]
            
            
            //Image
            let flightImgURL = WebServicesUrl.FlightImgURL + self.returnDetailsArr [indexPath.row].marketing + ".gif"
            result.flightImgView.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                if error == nil{
                    print("Image downloaded without error......")
                }else{
                    print("Error from SBWebImage Block = ",error!)
                }
                
            })

            return result
        }
        
        return UITableViewCell()
        
    }
    private func getParentCellIndex(expansionIndex: Int) -> Int {
        
        var selectedCell: FinalStruct?
        var selectedCellIndex = expansionIndex
        
        while(selectedCell == nil && selectedCellIndex >= 0) {
            selectedCellIndex -= 1
            selectedCell = myArray?[selectedCellIndex]
        }
        
        return selectedCellIndex
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        if let data = myArray?[indexPath.row] {
        
        if (myArray?[indexPath.row]) != nil {
            
            // If user clicked last cell, do not try to access cell+1 (out of range)
            if(indexPath.row + 1 >= (myArray?.count)!) {
                if myArray?[indexPath.row]?.stop != "0 stop" {
                    expandCell(tableView: tableView, index: indexPath.row)
                }else{
                    print("0 stop..so dont expand...lastcell")
                }
                
            }
            else {
                // If next cell is not nil, then cell is not expanded
                if(myArray?[indexPath.row+1] != nil) {
                    if myArray?[indexPath.row]?.stop != "0 stop" {
                        expandCell(tableView: tableView, index: indexPath.row)
                    }else{
                        print("0 stop..so dont expand...ReturnTrip")
                    }
                    
                    // Close Cell (remove ExpansionCells)
                } else {
                    contractCell(tableView: tableView, index: indexPath.row)
                    
                }
            }
        }
    }
    /*  Expand cell at given index  */
    private func expandCell(tableView: UITableView, index: Int) {
        // Expand Cell (add ExpansionCells
        
        /*
         if let flights = destinationData?[index]?.TripDetailsArr {
         for i in 1...flights.count {
         destinationData?.insert(nil, at: index + i)
         tableView.insertRows(at: [NSIndexPath(row: index + i, section: 0) as IndexPath] , with: .top)
         }
         }*/
        
        if let fli = myArray?[index]?.TripDetailsArr {
            for i in 1...fli.count {
                myArray?.insert(nil, at: index + i)
                tableView.insertRows(at: [NSIndexPath(row: index + i, section: 0) as IndexPath] , with: .top)
            }
        }
    }
    /*  Contract cell at given index    */
    private func contractCell(tableView: UITableView, index: Int) {
        
        if let flig = myArray?[index]?.TripDetailsArr {
            for _ in 1...flig.count {
                myArray?.remove(at: index+1)
                tableView.deleteRows(at: [NSIndexPath(row: index+1, section: 0) as IndexPath], with: .top)
                
            }
        }
    }
}

class MainCellClassGoomo : UITableViewCell{
    @IBOutlet weak var flightImgView: UIImageView?
    @IBOutlet weak var flightNameLbl: UILabel!
    @IBOutlet weak var depTimeLbl: UILabel!
    @IBOutlet weak var depAirportCodeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var stopDetailsLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    @IBOutlet weak var arrivalAirportCodeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var refundOrNonRefundLbl: UILabel!
    @IBOutlet weak var lineDesignVIew: UIView!
    @IBOutlet weak var detailLbl: UILabel!
    
    @IBOutlet weak var classTypeLbl: DesignableLabel!
    @IBOutlet weak var departureDateLbl: UILabel!
    @IBOutlet weak var arrivalDateLbl: UILabel!
}
class SubCellClassGoomo : UITableViewCell{
    @IBOutlet weak var flightImgView: UIImageView!
    @IBOutlet weak var flightNameLbl: UILabel!
    @IBOutlet weak var depTimeLbl: UILabel!
    @IBOutlet weak var depAirportCodeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var stopDetailsLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    @IBOutlet weak var arrivalAirportCodeLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var refundOrNonRefundLbl: UILabel!
    @IBOutlet weak var lineDesignVIew: UIView!
    @IBOutlet weak var detailLbl: UILabel!
    
    @IBOutlet weak var departureDateLbl: UILabel!
    @IBOutlet weak var arrivalDateLbl: UILabel!
}
//MARK: - LoginDelegate {
extension FlightReviewVCGoomo : LoginProtocolGoomo {
    
    //    func didSelectAirport(selectedAirportStruct: AirportStruct, controller: FlightPlacesVC) {
    //        controller.dismiss(animated: true, completion: nil)
    //        if fromOrTo == "from" {
    //            self.fromTxtField.text = selectedAirportStruct.cityName!
    //            self.fromAirportCodeLbl.text = selectedAirportStruct.airportCode!
    //            self.selectedOriginStruct = selectedAirportStruct
    //        }else{
    //            self.toTxtField.text = selectedAirportStruct.cityName!
    //            self.toAirportCodeLbl.text = selectedAirportStruct.airportCode!
    //            self.selectedDestinationStruct = selectedAirportStruct
    //        }
    //    }
    func didLoggedIn(selectedString: String, controller: LoginPageVCGoomo) {
        controller.navigationController?.popViewController(animated: true)
        if selectedString == "hideBtns"{
            self.continueBtn.isHidden = false
        }
    }
}
//MARK: - }
