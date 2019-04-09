//
//  FlightSearchViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 02/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit

class FlightSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UIPickerViewDataSource,UIPickerViewDelegate{

    @IBOutlet weak var nonstopImg: UIImageView!
    var className : [String] = [String]()
    var arrAdult : [String] = [String]()
    var arrChild : [String] = [String]()
    var arrInfant : [String] = [String]()
    var temp : String = String()
    var temp1 : String = String()
    var tempPos1 : CGRect = CGRect()
    var tempPos2 : CGRect = CGRect()
    var strAdult = "", strChild = "", strInfant : String = ""
    var isFlipped: Bool = false
    
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
    @IBOutlet weak var hotelBtn: UIButton!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var swapBtn: UIButton!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelView: UIView!
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var accountImg: UIImageView!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var bookingImg: UIImageView!
    @IBOutlet weak var bookingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classChooseView .isHidden = true
         travellerView .isHidden = true
     
        UserDefaults.standard.set("", forKey: "DselectedCityName")
        UserDefaults.standard.set("", forKey: "DselectedCityCode")
        UserDefaults.standard.set("", forKey: "AselectedCityName")
        UserDefaults.standard.set("", forKey: "AselectedCityCode")
        UserDefaults.standard.set("", forKey: "selectedDeptDate")
        UserDefaults.standard.set("", forKey: "selectedArrDate")
        UserDefaults.standard.set("", forKey: "selectedDeptDay")
        UserDefaults.standard.set("", forKey: "selectedArrDay")
       // UserDefaults.standard.set("twoway", forKey: "wayType")
         UserDefaults.standard.set("oneway", forKey: "wayType")
        classTableView.layer.cornerRadius = 5.0
         travelView.layer.cornerRadius = 5.0
        className = ["Economy Class","Premium Economy Class","Business Class","First Class"]
         arrAdult = ["1","2","3","4","5","6","7","8","9","10"]
         arrChild = ["0","1","2","3","4","5","6","7","8","9"]
         arrInfant = ["0","1","2","3","4","5","6","7","8","9"]
        
        tempPos1 = txtDeparture.frame
        tempPos2 = lblDepartureCity.frame
 
        ////// Botton Border
    
        hotelBtn.layer.borderWidth = 1
        hotelBtn.layer.borderColor = UIColor.gray.cgColor
        flightBtn.layer.borderWidth = 1
        flightBtn.layer.borderColor = UIColor.gray.cgColor
        
        ///SwipeGesture
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
//        swipeLeft.direction = .left
//        self.hotelView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.flightView.addGestureRecognizer(swipeRight)
    }
//MARK - SWipe Gesture
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
        }
}
    override func viewWillAppear(_ animated: Bool)
    {
        let departureCity = (UserDefaults.standard.value(forKey: "DselectedCityName") as! String)
        let departureCode = (UserDefaults.standard.value(forKey: "DselectedCityCode") as! String)
        let arrivalCity = (UserDefaults.standard.value(forKey: "AselectedCityName") as! String)
        let arrivalCode = (UserDefaults.standard.value(forKey: "AselectedCityCode") as! String)
        let selectedDeptDate = (UserDefaults.standard.value(forKey: "selectedDeptDate") as! String)
        let selectedArrDate = (UserDefaults.standard.value(forKey: "selectedArrDate") as! String)
        let selectedDeptDay = (UserDefaults.standard.value(forKey: "selectedDeptDay") as! String)
        let selectedArrDay = (UserDefaults.standard.value(forKey: "selectedArrDay") as! String)
        print("\(selectedDeptDate),\(selectedArrDate),\(selectedDeptDay),\(selectedArrDay)")
       if departureCity.isEmpty
       {
        txtDeparture .text = "Source"
       }
       else{
            txtDeparture .text = departureCode
            let mySubstring = String(departureCity.dropLast(5))
            lblDepartureCity.text = String(mySubstring)
            var last4 = departureCity.suffix(4)
            last4 = last4.dropLast(1)
            txtDeparture .text = String(last4)
        }
        if arrivalCity.isEmpty
        {
            txtArrival .text = "Departure"
        }
        else{
            txtArrival .text = arrivalCode
            let mySubstring = String(arrivalCity.dropLast(5))
            lblArrivalCity.text = String(mySubstring)
            var last4 = arrivalCity.suffix(4)
            last4 = last4.dropLast(1)
            txtArrival .text = String(last4)
        }
        if selectedDeptDate.isEmpty
        {
           // txtDeparture .text = "Source"
        }
        else{
            txtDepartureDate .text = selectedDeptDate
            lblDepartureDay.text = selectedDeptDay
        }
        if selectedArrDate.isEmpty
        {
            // txtDeparture .text = "Source"
        }
        else{
            txtArrivalDate .text = selectedArrDate
            lblArrivalDay .text = selectedArrDay
        }
        temp = txtDeparture.text!
        temp1 = lblDepartureCity.text!
      
    }
    
///////////// tableView DataSource - Delegate Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return className.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = className[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        txtClass . text = className[indexPath.row]
        classChooseView .isHidden = true
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose Class"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            //headerView.contentView.backgroundColor = .white
            headerView.textLabel?.textColor = WebServicesUrl.appColor1
            
        }
    }
////////////////////////////////////end of tableview

////////////////////////// PickerView Delegate- Datasource
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if (pickerView.tag == 1){
        return arrAdult.count
    }else if (pickerView.tag == 2){
        return arrChild.count
    }else{
        return arrInfant.count
    }
}

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    if (pickerView.tag == 1){
        return "\(arrAdult[row])"
    }else  if (pickerView.tag == 2){
        return "\(arrChild[row])"
    }else {
        return "\(arrInfant[row])"
    }
}
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
         if (pickerView.tag == 1)
         {
            strAdult = arrAdult[row]
        }
         else if (pickerView.tag == 2)
         {
            strChild = arrChild[row]
        }
        else
         {
            strInfant = arrInfant[row]
        }
       
       
    }
//////////////////////////

    @IBAction func segmentAction(_ sender: Any)
    {
        switch (sender as AnyObject).selectedSegmentIndex
        {
        case 0:
           UserDefaults.standard.set("oneway", forKey: "wayType")
        case 1:
            UserDefaults.standard.set("twoway", forKey: "wayType")
        default:
            break;
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func departureBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchCityVC") as? SearchCityViewController
        vc?.selectableCity = "departure"
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    @IBAction func arrivalBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchCityVC") as? SearchCityViewController
         vc?.selectableCity = "arrival"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func departureDateBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomCalenderVC") as? CustomCalenderViewController
         vc?.selectableDate = "departureDate"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func arrivalDateBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomCalenderVC") as? CustomCalenderViewController
         vc?.selectableDate = "arrivalDate"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func travellerChooseBtn(_ sender: Any)
    {
         travellerView .isHidden = false
    }
    
    @IBAction func classCHooseBtn(_ sender: Any)
    {
        classChooseView .isHidden = false
    }
    
    @IBAction func nonStopSelectionBtn(_ sender: Any)
    {
        if stopBtn.isSelected == true {
            stopBtn.isSelected = false
            nonstopImg.image = UIImage (named: "square.png")
         
        }else {
            stopBtn.isSelected = true
            nonstopImg.image = UIImage (named: "black-check-box-with-white-check.png")
        }
      
    }

    
    @IBAction func flightSearchBtn(_ sender: Any)
    {
//          let DictInput = ["Origin":self.originToPass!,"Destination":self.destinationToPass!,"DepartureDate":selectedDepartOnStrToPass!,"Returndate":selectedReturnOnStrToPass!,"WayType":self.onewayBtn.isSelected ? "one":"two","CabinClass":self.classSelectedItem,"AdultCount":self.adultSelectedItem,"ChildCount":self.childrenSelectedItem,"InfantCount":self.infantSelectedItem,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
      
        let DictInput = ["Origin":"SIN","Destination":"JFK","DepartureDate":"2019-05-15","Returndate":"2019-05-25","WayType":"two","CabinClass":"Economy","AdultCount":"1","ChildCount":"0","InfantCount":"0","SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
        
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "FlightResultVC") as! FlightResultVCGoomo
        ctrl.inputDict = DictInput
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func travellerSetBtn(_ sender: Any)
    {
        if(strAdult == "")
            {
             strAdult = "1"
        }
        if(strChild == "")
        {
            strChild = "0"
        }
        if(strInfant == "")
        {
            strInfant = "0"
        }
         txtTraveller . text = "\(strAdult) Adult, \(strChild) Child, \(strInfant) Infant"
         travellerView .isHidden = true
    }
    
    @IBAction func travellerCancelBtn(_ sender: Any)
    {
         travellerView .isHidden = true
    }
    
    @IBAction func swipeBtn(_ sender: Any)
    {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            button.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                button.transform = CGAffineTransform.identity
                            })
        })
        
        UIView.beginAnimations(nil, context: nil)
        if button.isSelected == true {
          //  swapBtn.isSelected = false
            txtDeparture.frame = txtArrival.frame
            txtArrival.frame   = tempPos1
            lblDepartureCity.frame = lblArrivalCity.frame
            lblArrivalCity.frame   = tempPos2
            txtDeparture.textAlignment = .right
            txtArrival.textAlignment = .left
            lblDepartureCity.textAlignment = .right
            lblArrivalCity.textAlignment  = .left
            txtDeparture.placeholder = "Destination"
            txtArrival . placeholder = "Source"

        }else {
           // swapBtn.isSelected = true
            txtArrival.frame = txtDeparture .frame
            txtDeparture.frame = tempPos1
            lblArrivalCity.frame = lblDepartureCity.frame
            lblDepartureCity.frame = tempPos2
            
            txtDeparture.textAlignment = .left
            txtArrival.textAlignment = .right
            lblDepartureCity.textAlignment = .left
            lblArrivalCity.textAlignment  = .right
            txtDeparture.placeholder = "Source"
            txtArrival . placeholder = "Destination"
        }
        UIView.commitAnimations()
    }
    
    @IBAction func hotleBtn(_ sender: Any)
    {
        hotelBtn.backgroundColor = WebServicesUrl.appColor2
        flightBtn.backgroundColor = UIColor.white
        flightBtn.setTitleColor(.darkGray, for: .normal)
        hotelBtn.setTitleColor(.white, for: .normal)
        hotelBtn .setImage(UIImage (named: "resort (2)"), for: UIControl.State.normal)
        flightBtn .setImage(UIImage (named: "plane"), for: UIControl.State.normal)
    }
    @IBAction func flightBtn(_ sender: Any)
    {
        flightBtn.backgroundColor = WebServicesUrl.appColor2
        hotelBtn.backgroundColor = UIColor.white
        flightBtn.setTitleColor(.white, for: .normal)
        hotelBtn.setTitleColor(.darkGray, for: .normal)
        hotelBtn .setImage(UIImage (named: "resort-1"), for: UIControl.State.normal)
        flightBtn .setImage(UIImage (named: "plane (1)"), for: UIControl.State.normal)
       
//        isFlipped = !isFlipped
//        let cardToFlip = isFlipped ? hotelView : flightView
//        let bottomCard = isFlipped ? flightView : hotelView
//                UIView.transition(with: cardToFlip!,
//                                  duration: 0.5,
//                                  options: [.transitionFlipFromRight],
//                                  animations:
//                    {
//                        cardToFlip?.isHidden =  true
//                    },
//                                  completion: { _ in
//                                    self.hotelView.bringSubviewToFront(bottomCard!)
//                                    cardToFlip?.isHidden = false
//                })
//        UIView.transition(with: flightView,
//                          duration: 0.5,
//                          options: [.transitionFlipFromRight],
//                          animations: {
//                            self.flightView.isHidden = false
//                            self.hotelView.isHidden = true
//        },
//                          completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
// MARK : Bottom View Action
    
    @IBAction func myBookingsBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeGray")
        homeLbl.textColor = UIColor.darkGray
        accountImg.image = UIImage (named: "userGray")
        accountLbl.textColor = UIColor.darkGray
        bookingImg.image = UIImage (named: "briefcaseRed")
        bookingLbl.textColor = WebServicesUrl.appColor2
    }
    
    @IBAction func myAccountBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeGray")
        homeLbl.textColor = UIColor.darkGray
        accountImg.image = UIImage (named: "userRed")
        accountLbl.textColor = WebServicesUrl.appColor2
        bookingImg.image = UIImage (named: "briefcaseGray")
        bookingLbl.textColor = UIColor.darkGray
    }
    
    @IBAction func homeBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeRed")
        homeLbl.textColor = WebServicesUrl.appColor2
        accountImg.image = UIImage (named: "userGray")
        accountLbl.textColor = UIColor.darkGray
        bookingImg.image = UIImage (named: "briefcaseGray")
        bookingLbl.textColor = UIColor.darkGray
    }
}
