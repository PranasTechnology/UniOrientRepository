//
//  FlightFilterVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 14/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SDWebImage

protocol FlightFilterDelegateGoomo {
    func didApplyBtnTapped(userSelectedFilterStruct : FlightUserSelectedFiltersStruct,controller : FlightFilterVCGoomo)
    func didBackBtnTapped(filterBtnTappedFlag : Bool,controller:FlightFilterVCGoomo)
}
class FlightFilterVCGoomo: UIViewController {

    @IBAction func resetBtnTapped(_ sender: UIBarButtonItem) {
    }
    var selectedFlightNameArr = [String]()
    
    var delegateVariable : FlightFilterDelegateGoomo!
    
    var uniqueFlightResultAndDetailArrBasedOnFlightName : [FlightResultAndDetailStruct]!
    
    
    @IBOutlet weak var nonStopBtn: DesignableButton!
    @IBOutlet weak var oneStopBtn: DesignableButton!
    @IBOutlet weak var twoStopBtn: DesignableButton!
    
    @IBOutlet weak var before11AMBtn: UIButton!
    @IBOutlet weak var elevenAMtoFivePMBtn: UIButton!
    @IBOutlet weak var fivePMToNinePMBtn: UIButton!
    @IBOutlet weak var afterNinePMBtn: UIButton!
    
    
    @IBOutlet weak var preferredAirlinesTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredAirlinesTV.delegate = self
        self.preferredAirlinesTV.dataSource = self
       
        print(uniqueFlightResultAndDetailArrBasedOnFlightName)
    }
    
    @IBAction func applyBtnTapped(_ sender: DesignableButton){
        
        let aSt = FlightUserSelectedFiltersStruct(preferredAirlinesArr: self.selectedFlightNameArr,isNonStop: nonStopBtn.isSelected, isOneStop: oneStopBtn.isSelected, isTwoPlusStops: twoStopBtn.isSelected, beforeElevenAM: before11AMBtn.isSelected, elevenAMToFivePM: elevenAMtoFivePMBtn.isSelected, fivePMToNinePM: fivePMToNinePMBtn.isSelected, afterNinePM: afterNinePMBtn.isSelected)

        print("Selected Filters are :",aSt)
        delegateVariable.didApplyBtnTapped(userSelectedFilterStruct: aSt, controller: self)
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        delegateVariable.didBackBtnTapped(filterBtnTappedFlag: false, controller: self)
       // self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        
        delegateVariable.didBackBtnTapped(filterBtnTappedFlag: false, controller: self)
        //        self.navigationController?.popViewController(animated: true)
    }
    func callBtnSelectionFunctionality(theBtn : DesignableButton){
        theBtn.isSelected = true
//        theBtn.backgroundColor = hexStringToUIColor(hex: "#AFCA1F") //TripArcher Green Color
        theBtn.backgroundColor = hexStringToUIColor(hex: "#16137c") //TripArcher Blue Color
        theBtn.setTitleColor(UIColor.white, for: .selected)
        theBtn.borderColor = UIColor.black
        theBtn.shadowOffset = CGSize(width: 0,height: 5)
        theBtn.shadowOpacity = 1
    }
    //ed2324 - Red 16137c - violet
    func callBtnNonSelectionFunctionality(theBtn : DesignableButton){
        theBtn.isSelected = false
        theBtn.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        theBtn.setTitleColor(UIColor.darkGray, for: .normal)
        theBtn.borderColor = hexStringToUIColor(hex: "#16137c")
        theBtn.shadowOffset = CGSize(width: 0,height: 0)
        theBtn.shadowOpacity = 0
        
    }
    @IBAction func nonStopBtnTapped(_ sender: DesignableButton) {
        
        !sender.isSelected ? callBtnSelectionFunctionality(theBtn: sender) : callBtnNonSelectionFunctionality(theBtn: sender)
        
        /*
         if !sender.isSelected {
         sender.isSelected = true
         
         sender.backgroundColor = hexStringToUIColor(hex: "#AFCA1F") //TripArcher Green Color
         sender.setTitleColor(UIColor.white, for: .selected)
         
         //            sender.layer.cornerRadius = 5
         //            sender.borderWidth = 2
         sender.borderColor = UIColor.black
         
         sender.shadowOffset = CGSize(width: 0,height: 5)
         sender.shadowOpacity = 1
         
         
         }else{
         sender.isSelected = false
         
         sender.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
         sender.setTitleColor(UIColor.darkGray, for: .normal)
         
         //            sender.layer.cornerRadius = 5
         //            sender.borderWidth = 2
         sender.borderColor = hexStringToUIColor(hex: "#AFCA1F")
         
         sender.shadowOffset = CGSize(width: 0,height: 0)
         sender.shadowOpacity = 0
         
         } */
        
    }
    
    @IBAction func oneStopBtnTapped(_ sender: DesignableButton) {
        
        !sender.isSelected ? callBtnSelectionFunctionality(theBtn: sender) : callBtnNonSelectionFunctionality(theBtn: sender)
        
        /*
         if !sender.isSelected {
         sender.isSelected = true
         
         sender.backgroundColor = hexStringToUIColor(hex: "#AFCA1F") //TripArcher Green Color
         sender.setTitleColor(UIColor.white, for: .selected)
         
         
         sender.borderColor = UIColor.black
         
         sender.shadowOffset = CGSize(width: 0,height: 5)
         sender.shadowOpacity = 1
         
         
         }else{
         sender.isSelected = false
         
         sender.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
         sender.setTitleColor(UIColor.darkGray, for: .normal)
         
         
         sender.borderColor = hexStringToUIColor(hex: "#AFCA1F")
         
         sender.shadowOffset = CGSize(width: 0,height: 0)
         sender.shadowOpacity = 0
         
         } */
    }
    
    @IBAction func twoStopBtnTapped(_ sender: DesignableButton) {
        !sender.isSelected ? callBtnSelectionFunctionality(theBtn: sender) : callBtnNonSelectionFunctionality(theBtn: sender)
        /*
         if !sender.isSelected {
         sender.isSelected = true
         
         sender.backgroundColor = hexStringToUIColor(hex: "#AFCA1F") //TripArcher Green Color
         sender.setTitleColor(UIColor.white, for: .selected)
         
         
         sender.borderColor = UIColor.black
         
         sender.shadowOffset = CGSize(width: 0,height: 5)
         sender.shadowOpacity = 1
         
         
         }else{
         sender.isSelected = false
         
         sender.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
         sender.setTitleColor(UIColor.darkGray, for: .normal)
         
         
         sender.borderColor = hexStringToUIColor(hex: "#AFCA1F")
         
         sender.shadowOffset = CGSize(width: 0,height: 0)
         sender.shadowOpacity = 0
         
         } */
    }
    
    @IBAction func before11AMBtnTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    
    @IBAction func elevenAMToFivePMBtnTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    
    @IBAction func fivePMToNinePMBtnTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    
    @IBAction func after9PMBtnTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
    }
    
    
    @objc func checkBoxBtnTapped (_sender : UIButton ){
        print("checkBox btn tapped :\(_sender.tag) ")
        if !_sender.isSelected {
            _sender.isSelected = true
            self.uniqueFlightResultAndDetailArrBasedOnFlightName[_sender.tag].isSelected = true
            selectedFlightNameArr.append(self.uniqueFlightResultAndDetailArrBasedOnFlightName[_sender.tag].flightName)
        }else{
            _sender.isSelected = false
            /*
             selectedFlightNameArr = selectedFlightNameArr.filter { (aString) -> Bool in
             if aString != self.uniqueFlightArr[_sender.tag].flightName {
             return true
             }else{
             return false
             }
             }*/
            self.uniqueFlightResultAndDetailArrBasedOnFlightName[_sender.tag].isSelected = false
            selectedFlightNameArr = selectedFlightNameArr.filter{$0 != self.uniqueFlightResultAndDetailArrBasedOnFlightName[_sender.tag].flightName}
        }
        
        print("selectedFlightNameArr = ",selectedFlightNameArr)
        preferredAirlinesTV.reloadData()
    }
}
extension FlightFilterVCGoomo : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.uniqueFlightResultAndDetailArrBasedOnFlightName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredAirlinesCell", for: indexPath) as! PreferredAirlinesCell
        
        cell.flightName.text = self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].flightName!
        
        //        if self.flightResultAndDetailsArr[indexPath.row].flightImgData != nil {
        //            cell.flightImgView.image = UIImage(data: self.flightResultAndDetailsArr[indexPath.row].flightImgData!)
        //        }else{
        //            cell.flightImgView.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "flightGreen"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
        //                if error == nil{
        //                    self.flightResultAndDetailsArr[indexPath.row].flightImgData = UIImagePNGRepresentation(downloadedImage!)
        //                }else{
        //                    print("Error from SBWebImage Block = ",error!)
        //                }
        //
        //            })
        //        }
        
        let flightImgURL = WebServicesUrl.FlightImgURL + self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].detailArrWithFlightDetailStruct[0].marketing + ".gif"
        
        if self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].flightImgData != nil {
            cell.imgView.image = UIImage(data: self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].flightImgData!)
        }else{
            cell.imgView.sd_setImage(with: URL(string: flightImgURL), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { downloadedImage, error, cacheType, imageURL in
                if error == nil{
                    self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].flightImgData = downloadedImage!.pngData()
                }else{
                    print("Error from SBWebImage Block = ",error!)
                }
                
            })
        }
        
        cell.preferredAirlinesSelectionBtn.addTarget(self, action: #selector(self.checkBoxBtnTapped), for: .touchUpInside)
        cell.preferredAirlinesSelectionBtn.tag = indexPath.row
        
        if self.uniqueFlightResultAndDetailArrBasedOnFlightName[indexPath.row].isSelected {
            cell.preferredAirlinesSelectionBtn.setImage(UIImage(named: "black-check-box-with-white-check.png"), for: .normal)
        }else{
            cell.preferredAirlinesSelectionBtn.setImage(UIImage(named: "square.png"), for: .normal)
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*
         let theCell = tableView.cellForRow(at: indexPath) as! PreferredAirlinesCellClass
         if  theCell.preferredAirlinesSelectionBtn.isSelected {
         theCell.preferredAirlinesSelectionBtn.isSelected = true
         selectedFlightNameArr.append(self.uniqueFlightArr[theCell.preferredAirlinesSelectionBtn.tag].flightName)
         }else{
         theCell.preferredAirlinesSelectionBtn.isSelected = false
         selectedFlightNameArr = selectedFlightNameArr.filter{$0 != self.uniqueFlightArr[theCell.preferredAirlinesSelectionBtn.tag].flightName}
         }
         
         print("selectedFlightNameArr = ",selectedFlightNameArr)
         preferredAirlinesTV.reloadData() */
        
    }
}

class PreferredAirlinesCell : UITableViewCell {
  
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var flightName: UILabel!
    @IBOutlet weak var preferredAirlinesSelectionBtn: UIButton!

}
