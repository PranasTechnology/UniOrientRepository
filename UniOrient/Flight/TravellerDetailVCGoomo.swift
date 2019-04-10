//
//  TravellerDetailVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 14/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class TravellerDetailVCGoomo: UIViewController {

  
    var ActualY : CGFloat = 0
    
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
            self.onewayOrTwowayImgView.image = UIImage.init(named: "Oneway100")
            self.dateLbl.text = selectedStruct.detailArrWithFlightDetailStruct.first?.departureDate
        }else{
            self.onewayOrTwowayImgView.image = UIImage.init(named: "Roundtrip100")
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
        self.amountLbl.attributedText = fStr
        
        mobileNoTxtField.delegate = self
        emailTxtField.delegate = self

        
        if let LoginDetal = FetchLoginDetails() {
            loginResponse = FetchLoginResponse()
            
            self.mobileNoTxtField.text = loginResponse.PhoneNo
            self.emailTxtField.text = LoginDetal.Email
            
            
        }else{
            
        }
        
        let Toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        //        let Toolbar = UIToolbar()
        Toolbar.barStyle = .default
        
        Toolbar.isTranslucent = true
        //        Toolbar.backgroundColor = hexStringToUIColor(hex: "#AFCA1F")
        Toolbar.barTintColor = hexStringToUIColor(hex: "#AFCA1F")
        Toolbar.tintColor = UIColor.black
        
        
        //        Toolbar.sizeToFit()
        
        let DoneItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(PickDoneAction(_:)))
        let FlexiItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        Toolbar.setItems([FlexiItem,DoneItem], animated: true)
        Toolbar.isUserInteractionEnabled = true
        
        //        mobileNoTxtField.inputView = shiftTypePicker
        mobileNoTxtField.inputAccessoryView = Toolbar
        //        mobileNoTxtField.tag = 1
        
        self.travellerListTV.tableFooterView = self.footerView
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
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
    
    //MARK: - Keyboard show
    var keyboardSize : CGRect?
    @objc func keyboardWillShow(_ notification : NSNotification){
        
        keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if !self.isKeyboardVisible{
            self.view.frame.origin.y -= keyboardSize!.height
        }
        self.isKeyboardVisible = true
        
    
        
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification)
    {
        if keyboardSize != nil{ // this condition is for, when keyboard is visible and tapping on backBtn crashes as self.keyboardSize is nil
            self.view.frame.origin.y += keyboardSize!.height
            self.isKeyboardVisible = false
        }else{
            print("KeyboardSize is nil ")
        }
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func proceedToPayBtnTapped(_ sender: UIButton) {
        
        
        for (idx,aStruct) in GrandArr.enumerated(){
            
            if aStruct.filterStr == nil{
                
                break
            }
            
            if idx == GrandArr.endIndex - 1 {
                print("EveryThing Provided")
                self.everythingProvidedFlag = true
            }
        }
        
        
        if everythingProvidedFlag {
            if !(self.emailTxtField.text?.isValidEmail())!{
                
            }else{
                print("Proceed to Pay....")
                if mobileNoTxtField.isFirstResponder {
                    mobileNoTxtField.resignFirstResponder()
                }
                if emailTxtField.isFirstResponder {
                    emailTxtField.resignFirstResponder()
                }
//                let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVCSBID") as! PaymentVC
//                self.navigationController?.pushViewController(ctrl, animated: true)
            }
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
class MyCellClassGoomo : UITableViewCell {
    
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

//extension TravellerDetailVCGoomo : SingleTravellerDetailProtocolGoomo {
//    func doneBtnTapped(_ structToPass: TravellerDetailStruct, _ controller: SingleTravellerDetailVCGoomo) {
//        print("Details of Traveller = ", structToPass)
//
//        let cell = travellerListTV.cellForRow(at: myIndexPath) as! MyCellClassGoomo
//        self.GrandArr[myIndexPath.row] = structToPass
//        cell.nameLbl.text = self.GrandArr[myIndexPath.row].firstName
//        cell.detailLbl.text = self.StaticArr[myIndexPath.row]
//        cell.detailLbl.textColor = UIColor.black
//
//        self.navigationController?.popViewController(animated: true)
//
//    }
//}
