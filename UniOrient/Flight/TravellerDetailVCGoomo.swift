//
//  TravellerDetailVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 14/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class TravellerDetailVCGoomo: UIViewController {

  
    @IBOutlet weak var termsandCondBtn: UIButton!
    var ActualY : CGFloat = 0
    var strURL : String = String()
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var travellerListTV: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    @IBOutlet weak var fromCityLbl: UILabel!
    @IBOutlet weak var onewayOrTwowayImgView: UIImageView!
    @IBOutlet weak var toCityLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var selectedStruct : FlightResultAndDetailStruct!
    var providedInputDict = [String:String]()
    var DictInput = Dictionary<String, String>()
    
    var adultCount : Int!
    var childCount : Int!
    var infantCount : Int!
    
    //    var adultIndex = 0
    var childIndex = 0
    var infantIndex = 0
    
    
    var myIndexPath : IndexPath!
    
    //    var GrandArr = [String]()
    var GrandArr = [TravellerDetailStruct]()
    var StaticArr = [String]()
    //    var detailLabelArr = [String]()
    
    var viewloadedFlag : Bool!
    
    @IBOutlet weak var mobileNoTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    var everythingProvidedFlag : Bool = false
    
    @IBOutlet weak var amountLbl: UILabel!
    
    
    var isKeyboardVisible : Bool = false
    var mobileNoTxtFieldFocusFlag : Bool!
    var emailTxtFieldFocusFlag : Bool!
    /*let keyboardDoneButton = UIButton(type: UIButton.ButtonType.custom) */
    
    var loginDetail : LoginDetails!
    var loginResponse : LoginResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewloadedFlag = true
        //        print("viewLoadedFlag = \(self.viewloadedFlag)")
        self.navigationController?.navigationBar.isHidden = false
        
        travellerListTV.delegate = self
        travellerListTV.dataSource = self
        
        adultCount = Int(self.providedInputDict["AdultCount"]!)
        childCount = Int(self.providedInputDict["ChildCount"]!)
        infantCount = Int(self.providedInputDict["InfantCount"]!)
        print("Count = ",(adultCount+childCount+infantCount))
        
        self.fromCityLbl.text = selectedStruct.detailArrWithFlightDetailStruct[0].fromCity
        self.toCityLbl.text = selectedStruct.detailArrWithFlightDetailStruct.last?.toCity
        if selectedStruct.wayType == "one" {
            self.onewayOrTwowayImgView.image = UIImage.init(named: "FlightCir")
            self.dateLbl.text = selectedStruct.detailArrWithFlightDetailStruct.first?.departureDate
        }else{
            self.onewayOrTwowayImgView.image = UIImage (named: "FlightCir")// UIImage.init(named: "FlightCir")
            self.dateLbl.text =  selectedStruct.detailArrWithFlightDetailStruct[0].departureDate! + " - " + selectedStruct.returnDetailArrWithFlightDetailStruct[0].departureDate!
        }
        
        //        self.amountLbl.text = "MYR." + selectedStruct.amount
        let fStr = NSMutableAttributedString()
        let attribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let xyz = NSAttributedString(string: self.selectedStruct.amount,attributes:attribute1)
        
        let attribute2 = [NSAttributedString.Key.foregroundColor : hexStringToUIColor(hex: "#338EDF"),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let abc = NSAttributedString(string: "MYR ", attributes: attribute2)
        
        fStr.append(abc)
        //        fStr.append(NSAttributedString(string: "\n"))
        fStr.append(xyz)
      //  self.amountLbl.attributedText = fStr
        
        mobileNoTxtField.delegate = self
        emailTxtField.delegate = self

        
        if let LoginDetal = FetchLoginDetails() {
            loginResponse = FetchLoginResponse()
            
            self.mobileNoTxtField.text = loginResponse.PhoneNo
            self.emailTxtField.text = LoginDetal.Email
            
            
        }else{
            
        }
        
        let Toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 40))
        //        let Toolbar = UIToolbar()
        Toolbar.barStyle = .default
        
        Toolbar.isTranslucent = true
        //        Toolbar.backgroundColor = hexStringToUIColor(hex: "#AFCA1F")
        Toolbar.barTintColor = hexStringToUIColor(hex: "#16137c")
        Toolbar.tintColor = UIColor.white
        
        
        //        Toolbar.sizeToFit()
        
        let DoneItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(PickDoneAction(_:)))
        let FlexiItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        Toolbar.setItems([FlexiItem,DoneItem], animated: true)
        Toolbar.isUserInteractionEnabled = true
        
        //        mobileNoTxtField.inputView = shiftTypePicker
        mobileNoTxtField.inputAccessoryView = Toolbar
        //        mobileNoTxtField.tag = 1
        self.travellerListTV.tableFooterView = self.footerView
   
///Keyboard Appear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),                                           name: UIResponder.keyboardWillShowNotification, object: nil)
        

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),                                           name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
  
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func PickDoneAction(_ sender:UIBarButtonItem) {
        self.view.endEditing(true)
    }
 
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewloadedFlag = false
    }
//    override func viewWillAppear(_ animated: Bool) {
//        func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIResponder.keyboardWillHideNotification, object: nil)
//
//        }
//        func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillHideNotification, object: nil)
//
//        }
    //MARK: - Keyboard show
    var keyboardSize : CGRect?
    @objc func keyboardWillShow(_ notification : NSNotification){
        
        keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if !self.isKeyboardVisible{
            self.view.frame.origin.y -= 150.0//keyboardSize!.height
        }
        self.isKeyboardVisible = true
     
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification)
    {
        if keyboardSize != nil{ // this condition is for, when keyboard is visible and tapping on backBtn crashes as self.keyboardSize is nil
            self.view.frame.origin.y += 150.0//keyboardSize!.height
            self.isKeyboardVisible = false
        }else{
            print("KeyboardSize is nil ")
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func proceedToPayBtnTapped(_ sender: UIButton)
    {
        
        for (idx,aStruct) in GrandArr.enumerated(){
            
            if aStruct.filterStr == nil{
                
                break
            }
            
            if idx == GrandArr.endIndex - 1 {
                print("EveryThing Provided")
                self.everythingProvidedFlag = true
            }
        }
        
        if everythingProvidedFlag
        {
            if !(self.emailTxtField.text?.isValidEmail())!{
                
            }else if (self.mobileNoTxtField.text == "")
            {
                print("Proceed to Pay....")
                if mobileNoTxtField.isFirstResponder {
                    mobileNoTxtField.resignFirstResponder()
                }
                if emailTxtField.isFirstResponder {
                    emailTxtField.resignFirstResponder()
                }
            }
            else{
                callBookingTransaction()
            }
            
            
//                let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVCSBID") as! PaymentVC
//                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    
    func callBookingTransaction()
    {
  
        var passengerDetails = "{DocumentElement}"
        for i in 0..<GrandArr.count {
            
            passengerDetails .append("{Passenger}")
            passengerDetails .append("{Travellertype}" + "1" + "{/Travellertype}")
             passengerDetails .append("{Title}" + "1" + "{/Title}")
             passengerDetails .append("{FirstName}" + self.GrandArr[i].firstName + "{/FirstName}")
             passengerDetails .append("{LastName}" + self.GrandArr[i].lastName + "{/LastName}")
             passengerDetails .append("{DOB}" + self.GrandArr[i].dateOfBirth + "{/DOB}")
             passengerDetails .append("{PassValidity}" + self.GrandArr[i].expiryDate + "{/PassValidity}")
             passengerDetails .append("{PassportNo}" + self.GrandArr[i].passportNo + "{/PassportNo}")
            passengerDetails .append("{/Passenger}")
           
        }
       passengerDetails .append("{/DocumentElement}")
        print("passengerDetails",passengerDetails)

///pricingDetails
        var pricingDetails = "{DocumentElement}"
            pricingDetails .append("{NoofAdult}" + "1" + "{/NoofAdult}")
            pricingDetails .append("{NoofChild}" + "0" + "{/NoofChild}")
            pricingDetails .append("{NoofInfant}" + "0" + "{/NoofInfant}")
            pricingDetails .append("{NoofPersons}" + "1" + "{/NoofPersons}")
            pricingDetails .append("{TotalFare}" + "2308" + "{/TotalFare}")
            pricingDetails .append("{APIAMT}" + "2308" + "{/APIAMT}")
            pricingDetails .append("{BaseFare}" + "2094" + "{/BaseFare}")
            pricingDetails .append("{MarkUp}" + "0.0" + "{/MarkUp}")
            pricingDetails .append("{Discount}" + "0.0" + "{/Discount}")
            pricingDetails .append("{Faretype}" + "Refundable" + "{/Faretype}")
            pricingDetails .append("{/DocumentElement}")
            print("pricingDetails",pricingDetails)
        
        ///IteneryDetails
        var iteneryDetails = "{DocumentElement}"
        iteneryDetails .append("{dairportall}" + "SIN~KUL~KUL~SIN" + "{/dairportall}")
        iteneryDetails .append("{flightnoall}" + "604~609" + "{/flightnoall}")
        iteneryDetails .append("{marketingall}" + "MH~MH" + "{/marketingall}")
        iteneryDetails .append("{durationall}" + "1h : 00m~0h : 55m" + "{/durationall}")
        iteneryDetails .append("{ddateall}" + "2019-02-27~2019-02-28" + "{/ddateall}")
        iteneryDetails .append("{adateall}" + "2019-02-27~2019-02-28" + "{/adateall}")
        iteneryDetails .append("{dtimeall}" + "095500~230000" + "{/dtimeall}")
        iteneryDetails .append("{atimeall}" + "105500~235500" + "{/atimeall}")
        iteneryDetails .append("{/DocumentElement}")
        print("iteneryDetails",iteneryDetails)
   
              DictInput = ["PassengerDetails":passengerDetails,"PricingDetails":pricingDetails,"ItieneraryDetails":iteneryDetails,"APIName":"Flight","FromCityName":"SIN","ToCityName":"KUL","EmailId":"rekha@gmail.com","MobileNo":"","Waytype":"two","Class":"Economy","AccountId":"IXCRAJ042","API":"20","IPAddress":"192.168.1.125","User_SK":"0","Address_SK":"0","MobileBooking":"0"]
        
        print(WebServicesUrl.FlightServiceUrl)
        print("DictInput",DictInput)
        if (Reachability()?.isReachable)! {
   WebService().HTTP_POST_WebServiceMethod_Flight(mainURL:WebServicesUrl.FlightServiceUrl,suffix: "APIBookingTransaction", parameterDict: DictInput) { (ResponceDict, success) in
    
                if success {
                    print("Service call success ..........")
            
                    let responce = ResponceDict as! [String:AnyObject]
                    print("result",responce)
                }}
        }
    }

    @IBAction func termsAndCondBtn(_ sender: Any)
    {
        if termsandCondBtn.isSelected == true {
            termsandCondBtn.isSelected = false
              termsandCondBtn .setImage(UIImage (named: "square.png"), for: UIControl.State.normal)
            
        }else {
            termsandCondBtn.isSelected = true
            termsandCondBtn .setImage(UIImage (named: "black-check-box-with-white-check.png"), for: UIControl.State.normal)
        }
    }
}
extension TravellerDetailVCGoomo : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (adultCount+childCount+infantCount)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellIDGoomo", for: indexPath) as! MyCellClassGoomo
        
        var aTravellerStruct = TravellerDetailStruct()
        if indexPath.row < adultCount {
            
            if self.viewloadedFlag {
                aTravellerStruct.firstName = "Adult \(indexPath.row + 1)"
                self.GrandArr.append(aTravellerStruct)
            }
            cell.nameLbl.text = self.GrandArr[indexPath.row].firstName
            
        }else if indexPath.row < (self.adultCount+self.childCount){
            
            childIndex += 1
            if self.viewloadedFlag {
                aTravellerStruct.firstName = "Child \(childIndex)"
                self.GrandArr.append(aTravellerStruct)
            }
            cell.nameLbl.text = self.GrandArr[indexPath.row].firstName
        }else if indexPath.row < (self.adultCount+self.childCount+self.infantCount){
            infantIndex += 1
            if self.viewloadedFlag {
                aTravellerStruct.firstName = "Infant \(infantIndex)"
                self.GrandArr.append(aTravellerStruct)
            }
            cell.nameLbl.text = self.GrandArr[indexPath.row].firstName
            
        }
        
        if self.viewloadedFlag {
            self.StaticArr.append(self.GrandArr[indexPath.row].firstName)
        }
//        if cell.detailLbl.textColor == UIColor.black {
//            print("Dont change Text Color - TravellerDetailVC")
//        }else{
//            cell.detailLbl.textColor = hexStringToUIColor(hex: "#2E65B0")
//        }
        
        if indexPath.row == (adultCount+childCount+infantCount) - 1{
            cell.cellBottomContraint.constant = 1
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("Tapped Cell index = \(indexPath.row)")
        
        self.myIndexPath = indexPath
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "SingleTravellerDetailVCGoomoSBID") as! SingleTravellerDetailVCGoomo
        ctrl.DelegateVar = self as? SingleTravellerDetailProtocolGoomo
        ctrl.travellerTVIndex = indexPath.row
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
}
class MyCellClassGoomo : UITableViewCell
{
    @IBOutlet weak var cellBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
}

extension TravellerDetailVCGoomo : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileNoTxtField {
            mobileNoTxtFieldFocusFlag = true
            emailTxtFieldFocusFlag = false
        }
        if textField == emailTxtField{
            emailTxtFieldFocusFlag = true
            mobileNoTxtFieldFocusFlag = false
        }
    }
}

extension TravellerDetailVCGoomo : SingleTravellerDetailProtocolGoomo {
    func doneBtnTapped(_ structToPass: TravellerDetailStruct, _ controller: SingleTravellerDetailVCGoomo) {
        print("Details of Traveller = ", structToPass)

        let cell = travellerListTV.cellForRow(at: myIndexPath) as! MyCellClassGoomo
        self.GrandArr[myIndexPath.row] = structToPass
        cell.nameLbl.text = self.GrandArr[myIndexPath.row].firstName
//        cell.detailLbl.text = self.StaticArr[myIndexPath.row]
//        cell.detailLbl.textColor = UIColor.black

        self.navigationController?.popViewController(animated: true)

    }
}
