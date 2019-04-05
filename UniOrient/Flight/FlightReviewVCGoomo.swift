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
    
    var selectedStruct : FlightResultAndDetailStruct!
    var providedInputDict = [String:String]()
    @IBOutlet weak var tvContainerView: UIView!
    @IBOutlet weak var myTV: UITableView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    var detailsArr = [FlightDetailStruct]()
    var returnDetailsArr = [FlightDetailStruct]()
    
    var myArray : [FinalStruct?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FetchLoginDetails() != nil {
            self.continueBtn.isHidden = false
        }else{
            self.continueBtn.isHidden = true
        }
       
        print("selected Struct = ",self.selectedStruct)
        //        self.amountLbl.text = "MYR " + self.selectedStruct.amount
        
        
        let fStr = NSMutableAttributedString()
        let attribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let xyz = NSAttributedString(string: self.selectedStruct.amount,attributes:attribute1)
        
        let attribute2 = [NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "#338EDF"),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let abc = NSAttributedString(string: "MYR ", attributes: attribute2)
        
        fStr.append(abc)
        //        fStr.append(NSAttributedString(string: "\n"))
        fStr.append(xyz)
        self.amountLbl.attributedText = fStr
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.detailsArr = selectedStruct.detailArrWithFlightDetailStruct
        let detailStructFinal =  FinalStruct.init(CabinBaggage: selectedStruct.CabinBaggage, CheckInBaggage: selectedStruct.CheckInBaggage, departureDate: selectedStruct.departureDate, arrivalDate: selectedStruct.arrivalDate,flightImgName:selectedStruct.flightImgName,flightImgData:selectedStruct.flightImgData, flightName: selectedStruct.flightName, departureTime: selectedStruct.departureTime, departureAirportCode: selectedStruct.departureAirportCode, duration: selectedStruct.duration, stop: selectedStruct.noOfStops, arrivalTime: selectedStruct.arrivalTime, arrivalAirportCode: selectedStruct.arrivalAirportCode,TripDetailsArr: detailsArr)
        
        
        self.myArray = [detailStructFinal]
        
        if selectedStruct.wayType == "two" {
            
            //            let flightImgURL = WebServicesUrl.FlightImgURL + selectedStruct.returnFlightImgName + ".gif"
            //            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: flightImgURL), options: .highPriority, progress: nil, completed: { (downloadedImg, downloadedData, error, isFinished) in
            //                if downloadedImg != nil{
            //                    self.selectedStruct.returnFlightImgData = downloadedData
            //                }
            //            })
            
            self.returnDetailsArr = selectedStruct.returnDetailArrWithFlightDetailStruct
            let returnDetailStructFinal = FinalStruct.init(CabinBaggage: "Nothing from DB", CheckInBaggage: "Nothing from DB",departureDate:selectedStruct.returnDepartureDate,arrivalDate:selectedStruct.returnArrivalDate,flightImgName:selectedStruct.returnFlightImgName,flightImgData:nil, flightName: selectedStruct.returnFlightName, departureTime: selectedStruct.returnDepartureTime, departureAirportCode: selectedStruct.returnDepartureAirportCode, duration: selectedStruct.returnDuration, stop: selectedStruct.returnNoofStops, arrivalTime: selectedStruct.returnArrivalTime, arrivalAirportCode: selectedStruct.returnArrivalAirportCode,TripDetailsArr: returnDetailsArr)
            
            self.myArray?.append(returnDetailStructFinal)
            
        }
        
      
        self.myTV.delegate = self
        self.myTV.dataSource = self
        
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
         if let data = destinationData {
         return data.count
         } else {
         return 0
         } */
        
        return myArray!.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Row is DefaultCell
        if var rowData = myArray?[indexPath.row] {
            let mainCell = tableView.dequeueReusableCell(withIdentifier: "MainCellIDGoomo", for: indexPath) as! MainCellClassGoomo
            
            if rowData.flightImgData != nil{
                // This if st. works for oneway.As oneways flightImgData will not be nil.It is passed from FlightResultVC
                mainCell.flightImgView?.image = UIImage(data: rowData.flightImgData!)
            }else{
                // This else works for returnflight.return flightImgData will be nil as we set in viewDidLoad.While tableview loads for first time,this else block will handle nil value of return flightImgData
                
                if rowData.flightImgName == "multiairline"{
                    mainCell.flightImgView?.image = UIImage(named: "multiairline")
                    rowData.flightImgData = UIImage(named: "multiairline")!.pngData()
                }else{
                    let flightImgURLStr = WebServicesUrl.FlightImgURL + rowData.flightImgName! + ".gif"
                    mainCell.flightImgView?.sd_setImage(with: URL(string: flightImgURLStr), placeholderImage: UIImage(named: "flightGreen"), options: SDWebImageOptions(rawValue: 0), completed: { (downloadedImg, error, cacheType, imageURL) in
                        if error == nil{
                            rowData.flightImgData = downloadedImg!.pngData()
                        }else{
                            print("Error from SBWebImage Block - FlightReviewVC = ",error!)
                        }
                    })
                }
                
                
            }
            
            mainCell.flightNameLbl.text = rowData.flightName
            mainCell.depTimeLbl.text = rowData.departureTime
            mainCell.depAirportCodeLbl.text = rowData.departureAirportCode
            mainCell.durationLbl.text = rowData.duration
            mainCell.stopDetailsLbl.text = rowData.stop
            mainCell.arrivalTimeLbl.text = rowData.arrivalTime
            mainCell.arrivalAirportCodeLbl.text = rowData.arrivalAirportCode
            
            mainCell.departureDateLbl.text = rowData.departureDate
            mainCell.arrivalDateLbl.text = rowData.arrivalDate
            mainCell.classTypeLbl.text = self.providedInputDict["CabinClass"]!
            
            if selectedStruct.wayType == "one" {
                mainCell.detailLbl.text = "Cabin Baggage : "+rowData.CabinBaggage + ",CheckIn Baggage :" + rowData.CheckInBaggage
            }else{
                mainCell.detailLbl.text = "No Baggage From Backend"
            }
         
            return mainCell
        }
            // Row is ExpansionCell
        else{
            if let rowData = myArray?[getParentCellIndex(expansionIndex: indexPath.row)] {
                //  Create an ExpansionCell
                let expansionCell = tableView.dequeueReusableCell(withIdentifier: "SubCellIDGoomo", for: indexPath) as! SubCellClassGoomo
                
                //  Get the index of the parent Cell (containing the data)
                let parentCellIndex = getParentCellIndex(expansionIndex: indexPath.row)
                
                //  Get the index of the flight data (e.g. if there are multiple ExpansionCells
                let flightIndex = indexPath.row - parentCellIndex - 1
                
                //  Set the cell's data
                /*
                 expansionCell.expCellLabel1.text = rowData.TripDetailsArr[flightIndex].tripName
                 expansionCell.expCellLabel2.text = rowData.TripDetailsArr[flightIndex].amount
                 expansionCell.selectionStyle = .none */
                
                /*
                 expansionCell.flightNameLbl.text = rowData.flightName
                 expansionCell.depTimeLbl.text = rowData.departureTime
                 expansionCell.depAirportCodeLbl.text = rowData.departureAirportCode
                 expansionCell.durationLbl.text = rowData.duration
                 expansionCell.stopDetailsLbl.text = rowData.stop
                 expansionCell.arrivalTimeLbl.text = rowData.arrivalTime
                 expansionCell.arrivalAirportCodeLbl.text = rowData.arrivalAirportCode */
                
                expansionCell.flightNameLbl.text = rowData.TripDetailsArr[flightIndex].operating
                let flightImgURL = WebServicesUrl.FlightImgURL + rowData.TripDetailsArr[flightIndex].marketing + ".gif"
                expansionCell.flightImgView.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "flightGreen"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                    if error == nil{
                        print("Image downloaded without error......")
                    }else{
                        print("Error from SBWebImage Block = ",error!)
                    }
                    
                })
                
                expansionCell.depTimeLbl.text = rowData.TripDetailsArr[flightIndex].departureTime
                
                let tempfromAirportCodeStr = rowData.TripDetailsArr[flightIndex].fromAirportName
                let startInd = tempfromAirportCodeStr?.index(after: (tempfromAirportCodeStr?.lastIndex(of: "("))!)
                let endInd = tempfromAirportCodeStr?.lastIndex(of: ")")
                let formattedFromStr = tempfromAirportCodeStr![startInd!..<endInd!]
                //                                print("Result = ",result)
                expansionCell.depAirportCodeLbl.text = String(formattedFromStr)
                
                
                //                expansionCell.depAirportCodeLbl.text = rowData.TripDetailsArr[flightIndex].fromAirportName
                expansionCell.durationLbl.text = rowData.TripDetailsArr[flightIndex].duration
                expansionCell.stopDetailsLbl.text = rowData.TripDetailsArr[flightIndex].stop
                expansionCell.arrivalTimeLbl.text = rowData.TripDetailsArr[flightIndex].arrivalTime
                //                expansionCell.arrivalAirportCodeLbl.text = rowData.TripDetailsArr[flightIndex].toAirportName
                
                let tempToAirportCodeStr = rowData.TripDetailsArr[flightIndex].toAirportName
                let startInde = tempToAirportCodeStr?.index(after: (tempToAirportCodeStr?.lastIndex(of: "("))!)
                let endInde = tempToAirportCodeStr?.lastIndex(of: ")")
                let formattedToStr = tempToAirportCodeStr![startInde!..<endInde!]
                //                                print("Result = ",result)
                expansionCell.arrivalAirportCodeLbl.text = String(formattedToStr)
                
                let tempDepDateArr = rowData.TripDetailsArr[flightIndex].departureDate.components(separatedBy: ",")
                expansionCell.departureDateLbl.text = tempDepDateArr[1]
                let tempArrivalDateArr = rowData.TripDetailsArr[flightIndex].arrivalDate.components(separatedBy: ",")
                expansionCell.arrivalDateLbl.text = tempArrivalDateArr[1]
                
                return expansionCell
            }
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
