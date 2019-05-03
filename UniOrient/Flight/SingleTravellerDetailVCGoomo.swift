//
//  SingleTravellerDetailVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 15/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

protocol SingleTravellerDetailProtocolGoomo {
    func doneBtnTapped(_ structToPass : TravellerDetailStruct , _ controller : SingleTravellerDetailVCGoomo )
}
class SingleTravellerDetailVCGoomo: UIViewController {

    @IBOutlet weak var passportNoTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var dateOfBirthTxtField: UITextField!
    @IBOutlet weak var expiryTxtField: UITextField!
    
    var DelegateVar:SingleTravellerDetailProtocolGoomo!
    var travellerTVIndex : Int!
    
    
    @IBOutlet weak var datePickerBGView: UIView!
    @IBOutlet weak var datePickerContainerView: UIView!
    
    
    var dateString : String!
    var dateFormatter = DateFormatter()
    
    
    var DOBDatePicker: UIDatePicker!
    var expiryDateDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        dateOfBirthTxtField.delegate = self
        passportNoTxtField.delegate = self
        expiryTxtField.delegate = self
        
//        myDatePicker = UIDatePicker()
        DOBDatePicker = UIDatePicker()
        expiryDateDatePicker = UIDatePicker()
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateString = dateFormatter.string(from: Date())
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        //        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        //        toolBar.backgroundColor = hexStringToUIColor(hex: "#AFCA1F")
        toolBar.barTintColor = hexStringToUIColor(hex: "#16137c")
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action:#selector(donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action:#selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
//        myDatePicker.datePickerMode = UIDatePickerMode.date
        DOBDatePicker.datePickerMode = UIDatePicker.Mode.date
        
        dateOfBirthTxtField.inputView = DOBDatePicker
        dateOfBirthTxtField.inputAccessoryView = toolBar
        
        expiryDateDatePicker.datePickerMode = UIDatePicker.Mode.date
        expiryTxtField.inputView = expiryDateDatePicker
        expiryTxtField.inputAccessoryView = toolBar
        
        //        datePickerBGView.isHidden = true
        //        dateOfBirthTxtField.inputView = datePickerBGView
        
        
        
        
        /*
         datepicker.datePickerMode = UIDatePickerMode.date
         datetextfield.inputView = datepicker
         datetextfield.inputAccessoryView = toolBar
         */
        
    }
    @objc func donePicker(sender : UIBarButtonItem) {
        
        if dateOfBirthTxtField.isFirstResponder {
            //            if dateOfBirthTxtField.text! != dateString! {
            //                timetextfield.text = "";
            //            }
            dateOfBirthTxtField.text = dateString
            self.dateOfBirthTxtField.resignFirstResponder()
        }
        if expiryTxtField.isFirstResponder{
            expiryTxtField.text = dateString
            self.expiryTxtField.resignFirstResponder()
        }
        
    }
    
    @objc func cancelPicker(sender : UIBarButtonItem ){
        if dateOfBirthTxtField.isFirstResponder {
            self.dateOfBirthTxtField.resignFirstResponder()
        }
        if expiryTxtField.isFirstResponder{
            self.expiryTxtField.resignFirstResponder()
        }
    }
    
    @IBOutlet weak var mrBtn: UIButton!
    @IBOutlet weak var msBtn: UIButton!
    @IBOutlet weak var mrsBtn: UIButton!
    var selectedTitle : String!
    
    @IBAction func mrBtnTapped(_ sender: UIButton) {
        print("mr btn tapped")
        mrBtn.isSelected = true
        msBtn.isSelected = false
        mrsBtn.isSelected = false
        selectedTitle = "Mr"
    }
    @IBAction func msBtnTapped(_ sender: UIButton) {
        print("ms btn tapped")
        mrBtn.isSelected = false
        msBtn.isSelected = true
        mrsBtn.isSelected = false
        selectedTitle = "Ms"
    }
    @IBAction func mrsBtnTapped(_ sender: UIButton) {
        print("mrs btn tapped")
        mrBtn.isSelected = false
        msBtn.isSelected = false
        mrsBtn.isSelected = true
        selectedTitle = "Mrs"
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        if !mrBtn.isSelected && !msBtn.isSelected && !mrsBtn.isSelected {
            
        }else if (firstNameTxtField.text?.isEmpty)! {
           
        }else if (lastNameTxtField.text?.isEmpty)! {
           
        }else if (dateOfBirthTxtField.text?.isEmpty)! {
           
        }else if (passportNoTxtField.text?.isEmpty)!{
          
        }else if (expiryTxtField.text?.isEmpty)!{
           
        }else{
            var structToPass = TravellerDetailStruct()
            structToPass.structIndex = "\(travellerTVIndex!)"
            structToPass.travellerTitle = selectedTitle!
            structToPass.firstName = firstNameTxtField.text!
            structToPass.lastName = lastNameTxtField.text!
            structToPass.dateOfBirth = dateOfBirthTxtField.text!
            structToPass.passportNo = passportNoTxtField.text!
            structToPass.expiryDate = expiryTxtField.text!
            structToPass.filterStr = "filled" // This parameter is for, showing toast if value is not provided in the tableview textfields.One Struct for traveller is created.
            
            DelegateVar.doneBtnTapped(structToPass, self)
        }
    }
    
    //The Container of the following method is hidden
    @IBAction func datePickerDoneBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        //        self.datePickerBGView.isHidden = true
        print("The Selected Date =",dateString)
        self.dateOfBirthTxtField.text = dateString
    }

}
extension SingleTravellerDetailVCGoomo : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*
         if textField == dateOfBirthTxtField || textField == expiryTxtField{
         //            datePickerBGView.isHidden = false
         //            myDatePicker.isHidden = false
         dateString = dateFormatter.string(from: Date())
         //            datepicker.minimumDate = NSDate() as Date
         let calendar:NSCalendar = NSCalendar.current as NSCalendar
         let components = calendar.components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from: NSDate() as Date)
         let date = calendar.date(from: components)!
         myDatePicker.setDate(date, animated: true)
         myDatePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControlEvents.valueChanged)
         } */
        
        if textField == dateOfBirthTxtField {
            dateString = dateFormatter.string(from: Date())
            let calendar:NSCalendar = NSCalendar.current as NSCalendar
            let components = calendar.components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from: NSDate() as Date)
            let date = calendar.date(from: components)!
            DOBDatePicker.maximumDate = date
            DOBDatePicker.setDate(date, animated: true)
            DOBDatePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControl.Event.valueChanged)
        }
        if textField == expiryTxtField {
            dateString = dateFormatter.string(from: Date())
            let calendar:NSCalendar = NSCalendar.current as NSCalendar
            let components = calendar.components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from: NSDate() as Date)
            let date = calendar.date(from: components)!
            expiryDateDatePicker.minimumDate = Date()
            expiryDateDatePicker.setDate(date, animated: true)
            expiryDateDatePicker.addTarget(self, action: #selector(handleDatePicker), for: UIControl.Event.valueChanged)
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        dateString = dateFormatter.string(from: sender.date)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
