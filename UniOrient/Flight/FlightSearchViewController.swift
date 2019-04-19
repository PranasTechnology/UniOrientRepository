//
//  FlightSearchViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 02/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit


class FlightSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UIPickerViewDataSource,UIPickerViewDelegate
{
//////// swipe Menu
    
    @IBOutlet weak var onewayScroll: UIScrollView!
    @IBOutlet weak var roundTripScroll: UIScrollView!
    @IBOutlet weak var multiCityBtn: UIButton!
    @IBOutlet weak var roundTripBtn: UIButton!
    @IBOutlet weak var onewayBtn: UIButton!
  
    
////////
    
    @IBOutlet weak var multicityTableView: UITableView!
    
    @IBOutlet var multiCityBottomView: UIView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var nonstopImg: UIImageView!
    
    @IBOutlet weak var RnonStopImg: UIImageView!
     var dateFormatter = DateFormatter()
    var className : [String] = [String]()
    var arrAdult : [String] = [String]()
    var arrChild : [String] = [String]()
    var arrInfant : [String] = [String]()
    
    var arrMultiTitle : [String] = [String]()
    var arrMultiDepartCode : [String] = [String]()
    var arrMultiDepartCity : [String] = [String]()
    var arrMultiArriCode : [String] = [String]()
    var arrMultiArriCity : [String] = [String]()
    var arrMultiDate : [String] = [String]()
    var arrMultiDay : [String] = [String]()
    
    var temp : String = String()
    var temp1 : String = String()
    var temps : String = String()
    var temps1 : String = String()
    
    var multiChoose : String = String()
    var tempPos1 : CGRect = CGRect()
    var tempPos2 : CGRect = CGRect()
    var tempPos11 : CGRect = CGRect()
    var tempPos22 : CGRect = CGRect()
    var strAdult = "", strChild = "", strInfant : String = ""
    var isFlipped: Bool = false
    var wayType : String = String()
    var index : Int = 0
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
    
    @IBOutlet weak var RstopBtn: UIButton!
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
    
     @IBOutlet var scrollPager: ScrollPager!
    
/////////// RoundTrip Controls
    
    @IBOutlet weak var RdepartureCity: UITextField!
    @IBOutlet weak var lblRdepartureCountry: UILabel!
    @IBOutlet weak var Rarrivalcity: UITextField!
    @IBOutlet weak var lblRarrivalCountry: UILabel!
    @IBOutlet weak var RdepartureDate: UITextField!
    @IBOutlet weak var lblRdepartureDay: UILabel!
    @IBOutlet weak var RarrivalDate: UITextField!
    @IBOutlet weak var lblRarrivalDay: UILabel!
    @IBOutlet weak var RtxtClass: UITextField!
    @IBOutlet weak var RtxtTraveller: UITextField!
    ///////
    @IBOutlet var roundTripView: UIView!
    @IBOutlet var onewayView: UIView!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multiNonstopImg: UIImageView!
    @IBOutlet weak var multiTraveller: UITextField!
    
    @IBOutlet weak var multiStopBtn: UIButton!
    @IBOutlet weak var txtMultiClass: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        onewayBtn.layer.cornerRadius = 10.0
        onewayBtn.clipsToBounds = true
        
        roundTripBtn.layer.cornerRadius = 10.0
        roundTripBtn.clipsToBounds = true
        
        multiCityBtn.layer.cornerRadius = 10.0
        multiCityBtn.clipsToBounds = true
        
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
         UserDefaults.standard.set("two", forKey: "wayType")
        classTableView.layer.cornerRadius = 5.0
         travelView.layer.cornerRadius = 5.0
        className = ["Economy Class","Premium Economy Class","Business Class","First Class"]
        arrMultiTitle = ["   Flight 1   ","   Flight 2   ","   Flight 3   "]
        arrMultiDepartCode = ["Source","Source","Source"]
        arrMultiDepartCity = ["Select City","Select City","Select City"]
        arrMultiArriCode = ["Destination","Destination","Destination"]
        arrMultiArriCity = ["Select City","Select City","Select City"]
        arrMultiDate = ["Date","Date","Date"]
        arrMultiDay = ["Day","Day","Day"]
        
//        [arrFromCityCode addObject:@"Source"];
//        [arrFromCityName addObject:@"Select City"];
//        [arrToCityCode addObject:@"Destination"];
//        [arrToCityName addObject:@"Select City"];
//
         arrAdult = ["1","2","3","4","5","6","7","8","9","10"]
         arrChild = ["0","1","2","3","4","5","6","7","8","9"]
         arrInfant = ["0","1","2","3","4","5","6","7","8","9"]

        tempPos1 = txtDeparture.frame
        tempPos2 = lblDepartureCity.frame

        tempPos11 = RdepartureCity.frame
        tempPos22 = lblRdepartureCountry.frame
        wayType="two"
        ////// Botton Border

//        hotelBtn.layer.borderWidth = 1
//        hotelBtn.layer.borderColor = UIColor.gray.cgColor
//        flightBtn.layer.borderWidth = 1
//        flightBtn.layer.borderColor = UIColor.gray.cgColor


   /// call Get Current date function
        strAdult = "1"
        strChild = "0"
        strInfant = "0"
        self .getCurrentDate()
        multicityTableView.tableFooterView = multiCityBottomView


// //// New COde
//        let imageView = UIImageView()
//        imageView.frame = CGRect(x: 30, y: 20, width: self.view.frame.width-60, height: 50)
//        imageView.image = UIImage (named: "Logo.png")
//        self.view.addSubview(imageView)
//
        // MARK: - Scroll menu setup
        
       
    }
  
    // MARK: - ScrollPagerDelegate -
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int)
    {
        if(changedIndex == 0)
        {
            wayType = "one"
            UserDefaults .standard .set("one", forKey: "wayType")
        }
        else if(changedIndex == 1)
        {
            wayType = "two"
            UserDefaults .standard .set("two", forKey: "wayType")
        }
        else if(changedIndex == 2)
        {
            wayType = "multi"
            UserDefaults .standard .set("multi", forKey: "wayType")
        }
    
    }
    
//MARK - SWipe Gesture
   
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
        }
        
/// Segmented COntrol
        
//        let titles = ["One Way", "Round Trip", "Multi City"]
//        let frame = CGRect(x: 20, y: segmentView.frame.height/2-30, width: segmentView.frame.width - 40, height: 50)
//
//        let segmentedControl = TwicketSegmentedControl(frame: frame)
//        segmentedControl.setSegmentItems(titles)
//        segmentedControl.delegate = self as? TwicketSegmentedControlDelegate
//
//        segmentView.addSubview(segmentedControl)
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

        if arrivalCity.isEmpty
        {
//            if(wayType == "one")
//            {
//                txtArrival .text = "Departure"
//            }
//            else{
//                Rarrivalcity .text = "Departure"
//            }

        }
        else{

            if(wayType == "one")
        {
            txtArrival .text = arrivalCode
            let mySubstring = String(arrivalCity.dropLast(5))
            lblArrivalCity.text = String(mySubstring)
            var last4 = arrivalCity.suffix(4)
            last4 = last4.dropLast(1)
            txtArrival .text = String(last4)
            }
            else if(wayType == "two"){
                Rarrivalcity .text = arrivalCode
                let mySubstring = String(arrivalCity.dropLast(5))
                lblRarrivalCountry.text = String(mySubstring)
                var last4 = arrivalCity.suffix(4)
                last4 = last4.dropLast(1)
                Rarrivalcity .text = String(last4)
            }
            else
            {
                if(multiChoose == "arrive")
                {
                    let mySubstring = String(arrivalCity.dropLast(5))
                    var last4 = arrivalCity.suffix(4)
                    last4 = last4.dropLast(1)
                    if(index == 0)
                    {
                        arrMultiArriCity.insert(String(mySubstring), at: 0)
                        arrMultiArriCode.insert(String(last4), at: 0)
                    }
                    else if(index == 1)
                    {
                        arrMultiArriCity.insert(String(mySubstring), at: 1)
                        arrMultiArriCode.insert(String(last4), at: 1)
                    }
                    else if(index == 2)
                    {
                        arrMultiArriCity.insert(String(mySubstring), at: 2)
                        arrMultiArriCode.insert(String(last4), at: 2)
                    }
                    multicityTableView .reloadData()
                }

            }
        }
        if departureCity.isEmpty
        {

        }
        else{

            if(wayType == "one")
            {
                txtDeparture .text = departureCode
                let mySubstring = String(departureCity.dropLast(5))
                lblDepartureCity.text = String(mySubstring)
                var last4 = departureCity.suffix(4)
                last4 = last4.dropLast(1)
                txtDeparture .text = String(last4)
            }
            else if(wayType == "two"){
                RdepartureCity .text = departureCode
                let mySubstring = String(departureCity.dropLast(5))
                lblRdepartureCountry.text = String(mySubstring)
                var last4 = departureCity.suffix(4)
                last4 = last4.dropLast(1)
                RdepartureCity .text = String(last4)
            }
            else
            {
                if(multiChoose == "depart")
                {
                    let mySubstring = String(departureCity.dropLast(5))
                    var last4 = departureCity.suffix(4)
                    last4 = last4.dropLast(1)
                    if(index == 0)
                    {
                        arrMultiDepartCity.insert(String(mySubstring), at: 0)
                        arrMultiDepartCode.insert(String(last4), at: 0)
                    }
                    else if(index == 1)
                    {
                        arrMultiDepartCity.insert(String(mySubstring), at: 1)
                        arrMultiDepartCode.insert(String(last4), at: 1)
                    }
                    else if(index == 2)
                    {
                        arrMultiDepartCity.insert(String(mySubstring), at: 2)
                        arrMultiDepartCode.insert(String(last4), at: 2)
                    }
                    multicityTableView .reloadData()
                }
            }

        }
        if selectedDeptDate.isEmpty
        {
           // txtDeparture .text = "Source"
        }
        else{
            if(wayType == "one")
            {
                txtDepartureDate .text = selectedDeptDate
                lblDepartureDay.text = selectedDeptDay
            }else if(wayType == "two")
            {
                RdepartureDate .text = selectedDeptDate
                lblRdepartureDay.text = selectedDeptDay
            }else{
                if(index == 0)
                {
                    arrMultiDate.insert(String(selectedDeptDate), at: 0)
                    arrMultiDay.insert(String(selectedDeptDay), at: 0)
                }
                else if(index == 1)
                {
                    arrMultiDate.insert(String(selectedDeptDate), at: 1)
                    arrMultiDay.insert(String(selectedDeptDay), at: 1)
                }
                else if(index == 2)
                {
                    arrMultiDate.insert(String(selectedDeptDate), at: 2)
                    arrMultiDay.insert(String(selectedDeptDay), at: 2)
                }
                multicityTableView .reloadData()
            }

        }
        if selectedArrDate.isEmpty
        {
            // txtDeparture .text = "Source"
        }
        else{
            RarrivalDate .text = selectedArrDate
            lblRarrivalDay .text = selectedArrDay
        }
        temp = txtDeparture.text!
        temp1 = lblDepartureCity.text!
        temps = RdepartureCity.text!
        temps1 = lblRdepartureCountry.text!

    }
 
///////////// tableView DataSource - Delegate Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == multicityTableView)
        {
            return arrMultiTitle.count
        }
        else{
            return className.count
        }
        
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(tableView == multicityTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
       
            let title = cell.viewWithTag(1) as! UILabel
            let departCode = cell.viewWithTag(4) as! UILabel
            let departCity = cell.viewWithTag(5) as! UILabel
            let arriCode = cell.viewWithTag(6) as! UILabel
            let arriCity = cell.viewWithTag(7) as! UILabel
            let departDate = cell.viewWithTag(8) as! UILabel
            let departDay = cell.viewWithTag(9) as! UILabel
            let departBtn = cell.viewWithTag(11) as! UIButton
            let ArriBtn = cell.viewWithTag(22) as! UIButton
            let DateBtn = cell.viewWithTag(33) as! UIButton

            title.text = arrMultiTitle[indexPath.row]
            departCode.text = arrMultiDepartCode[indexPath.row]
            departCity.text = arrMultiDepartCity[indexPath.row]
            arriCode.text = arrMultiArriCode[indexPath.row]
            arriCity.text = arrMultiArriCity[indexPath.row]
            departDate.text = arrMultiDate[indexPath.row]
            departDay.text = arrMultiDay[indexPath.row]

            departBtn.addTarget(self, action: #selector(departBtnClicked(sender:)), for: .touchUpInside)
            ArriBtn.addTarget(self, action:#selector(arriBtnClicked(sender:)), for: .touchUpInside)
            DateBtn.addTarget(self, action:#selector(dateBtnClicked(sender:)), for: .touchUpInside)
          //  departBtn.tag = indexPath.row
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
            let label1 = cell.viewWithTag(1) as! UILabel
            label1.text = className[indexPath.row]
            return cell
        }
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == multicityTableView)
        {
            return 130.0
        }
        else
        {
            return 50.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(tableView == multicityTableView)
        {
            print("HELLO")
        }
        else if(tableView == classTableView)
        {
            if(wayType == "one")
            {
                txtClass . text = className[indexPath.row]
            }else if(wayType == "two")
            {
                RtxtClass . text = className[indexPath.row]
            }else{
                  txtMultiClass . text = className[indexPath.row]
            }
            
            classChooseView .isHidden = true
        }else{
       
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchCityVC") as? SearchCityViewController
            vc?.selectableCity = "departure"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
     
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(tableView == classTableView)
        {
            return "Choose Class"
        }
        else{
            return ""
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            //headerView.contentView.backgroundColor = .white
            headerView.textLabel?.textColor = WebServicesUrl.appColor2
            
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
        if(wayType == "one"){
            if stopBtn.isSelected == true {
                stopBtn.isSelected = false
                nonstopImg.image = UIImage (named: "square.png")
                
            }else {
                stopBtn.isSelected = true
                nonstopImg.image = UIImage (named: "black-check-box-with-white-check.png")
            }
        }
        else if(wayType == "two"){
            if RstopBtn.isSelected == true {
                RstopBtn.isSelected = false
                RnonStopImg.image = UIImage (named: "square.png")
                
            }else {
                RstopBtn.isSelected = true
                RnonStopImg.image = UIImage (named: "black-check-box-with-white-check.png")
            }
        }
       else
        {
            if multiStopBtn.isSelected == true {
                multiStopBtn.isSelected = false
                multiNonstopImg.image = UIImage (named: "square.png")
                
            }else {
                multiStopBtn.isSelected = true
                multiNonstopImg.image = UIImage (named: "black-check-box-with-white-check.png")
            }
        }
      
    }

    
    @IBAction func flightSearchBtn(_ sender: Any)
    {
//          let DictInput = ["Origin":self.originToPass!,"Destination":self.destinationToPass!,"DepartureDate":selectedDepartOnStrToPass!,"Returndate":selectedReturnOnStrToPass!,"WayType":self.onewayBtn.isSelected ? "one":"two","CabinClass":self.classSelectedItem,"AdultCount":self.adultSelectedItem,"ChildCount":self.childrenSelectedItem,"InfantCount":self.infantSelectedItem,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
      
       var DictInput = Dictionary<String, String>()
        if(wayType == "one")
        {
            var departDate : String = String()
            departDate = convertDateFormater(txtDepartureDate.text!)
            print("date",departDate)
            DictInput = ["Origin":txtDeparture.text!,"Destination":txtArrival.text! ,"DepartureDate":departDate,"Returndate":"","WayType":"one","CabinClass":txtClass.text!,"AdultCount":strAdult,"ChildCount":strChild,"InfantCount":strInfant,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
        }
        else if(wayType == "two"){
            var departDate : String = String()
            departDate = convertDateFormater(RdepartureDate.text!)
            print("date",departDate)
            var arriveDate : String = String()
            arriveDate = convertDateFormater(RarrivalDate.text!)
            print("date",arriveDate)
            
            DictInput = ["Origin":RdepartureCity.text!,"Destination":Rarrivalcity.text!,"DepartureDate":departDate,"Returndate":arriveDate,"WayType":"two","CabinClass":RtxtClass.text!,"AdultCount":strAdult,"ChildCount":strChild,"InfantCount":strInfant,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
        }
        else{
            var departDate1 : String = String()
            departDate1 = convertDateFormater(arrMultiDate[0])
            print("date",departDate1)
            var departDate2 : String = String()
            departDate2 = convertDateFormater(arrMultiDate[1])
            print("date",departDate2)
            var departDate3 : String = String()
            departDate3 = convertDateFormater(arrMultiDate[2])
            print("date",departDate3)
            DictInput = ["Origin1":"SIN","Destination1":"KUL","DepartureDate1":"2019-05-15","Origin2":"KUL","Destination2":"JFK","DepartureDate2":"2019-05-20","Origin3":"JFK","Destination3":"SIN","DepartureDate3":"2019-05-25","WayType":"multi","CabinClass":txtMultiClass.text!,"AdultCount":strAdult,"ChildCount":strChild,"InfantCount":strInfant,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON","WayCount":"3"]
            
//            DictInput = ["Origin1":arrMultiDepartCode[0],"DepartureDate1":departDate1,"Origin2":arrMultiDepartCode[1],"DepartureDate2":departDate2,"Origin3":arrMultiDepartCode[2],"DepartureDate3":departDate3,"WayType":"multi","CabinClass":txtMultiClass.text!,"AdultCount":strAdult,"ChildCount":strChild,"InfantCount":strInfant,"SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON","WayCount":"3"]
        }
//        @"%@FlightResultMultiWay?Origin1=%@&Destination1=%@&DepartureDate1=%@&Origin2=%@&Destination2=%@&DepartureDate2=%@&Origin3=%@&Destination3=%@&DepartureDate3=%@&WayType=%@&NonStop=&CabinClass=%@&AdultCount=%@&ChildCount=%@&InfantCount=%@&SeniorCount=%@&PreferredCarrier=%@&PromotionalPlanType=%@&SearchSessionid=%@&moduleid=%@&ParentAccountId=%@&ChildAccountId=%@&ApiName=%@&ReqType=%@&WayCount=3",
//        DictInput = ["Origin":"SIN","Destination":"JFK","DepartureDate":"2019-05-15","Returndate":"2019-05-25","WayType":"two","CabinClass":"Economy","AdultCount":"1","ChildCount":"0","InfantCount":"0","SeniorCount":"0","PreferredCarrier":"1","PromotionalPlanType":"0","SearchSessionid":"0","ModuleId":"14","ParentAccountId":"IXCRAJ042","ChildAccountId":"IXCRAJ042","ApiName":"TBO","NonStop":"","ReqType":"JSON"]
        
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
        if(wayType == "one")
        {
              txtTraveller . text = "\(strAdult) Adult, \(strChild) Child, \(strInfant) Infant"
        }
        else if(wayType == "two")
        {
             RtxtTraveller . text = "\(strAdult) Adult, \(strChild) Child, \(strInfant) Infant"
        }
        else
        {
              multiTraveller . text = "\(strAdult) Adult, \(strChild) Child, \(strInfant) Infant"
        }
       
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
       if(wayType == "one")
       {
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
        }
        else
       {
        if button.isSelected == true {
            //  swapBtn.isSelected = false
            RdepartureCity.frame = Rarrivalcity.frame
            Rarrivalcity.frame   = tempPos11
            lblRdepartureCountry.frame = lblRarrivalCountry.frame
            lblRarrivalCountry.frame   = tempPos22
            RdepartureCity.textAlignment = .right
            Rarrivalcity.textAlignment = .left
            lblRdepartureCountry.textAlignment = .right
            lblRarrivalCountry.textAlignment  = .left
            RdepartureCity.placeholder = "Destination"
            Rarrivalcity . placeholder = "Source"
            
        }else {
            // swapBtn.isSelected = true
            Rarrivalcity.frame = RdepartureCity .frame
            RdepartureCity.frame = tempPos11
            lblRarrivalCountry.frame = lblRdepartureCountry.frame
            lblRdepartureCountry.frame = tempPos22
            
            RdepartureCity.textAlignment = .left
            Rarrivalcity.textAlignment = .right
            lblRdepartureCountry.textAlignment = .left
            lblRarrivalCountry.textAlignment  = .right
            RdepartureCity.placeholder = "Source"
            Rarrivalcity . placeholder = "Destination"
        }
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
    
    //////Get current date
    func getCurrentDate()
    {
        let date1 = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM,yyyy"//"YYYY-MM-dd"//"dd MMM yy"//2019-05-15
        let result = formatter.string(from: date1)
        print(result)
        
        /////getDay
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        print(dayInWeek)
        
        /////////get nextdate
        
        print(convertNextDate(dateString: result))
        
        //////////
        
        txtDepartureDate . text = result
        lblDepartureDay.text = dayInWeek
        RdepartureDate . text = result
        lblRdepartureDay.text = dayInWeek
        arrMultiDate .insert(result, at: 0)
        arrMultiDay .insert(dayInWeek, at: 0)
         multicityTableView .reloadData()
        //        if(wayType == "one")
        //        {
        //            txtDepartureDate . text = result
        //            lblDepartureDay.text = dayInWeek
        //           // txtArrivalDate.text = "\(String.convertNextDate(result))"
        //        }
        //        else  if(wayType == "two")
        //        {
        //            RdepartureDate . text = result
        //            lblRdepartureDay.text = dayInWeek
        //          //  RarrivalDate.text = "\(String.convertNextDate(result))"
        //        }
    }
    func convertNextDate(dateString : String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"//"YYYY-MM-dd"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        print("your next Date is2 \(somedateString)")
      
        
///Get next day
        let isoDate = somedateString
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd MMM,yyyy"//"YYYY-MM-dd"
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date2 = dateFormatter1.date(from:isoDate)!
        print(date2)
        let dayInWeek1 = dateFormatter.string(from: date2)
        
        let date = date2
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        let dayInWeek = dateFormatter2.string(from: date)
        print(dayInWeek)
        
        print("your next day is \(dayInWeek)")
        lblRarrivalDay.text = "\(dayInWeek)"
        RarrivalDate .text = "\(somedateString)"
        arrMultiDay .insert("\(dayInWeek)", at: 0)
        arrMultiDate .insert("\(somedateString)", at: 0)
       multicityTableView .reloadData()
       print(convertNextDate1(dateString: somedateString))
    }
    
    
    func convertNextDate1(dateString : String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"//"YYYY-MM-dd"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        print("your next Date is3 \(somedateString)")
        RarrivalDate .text = "\(somedateString)"
        arrMultiDate .insert("\(somedateString)", at: 1)
        
        
        ///Get next day
        let isoDate = somedateString
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd MMM,yyyy"//"YYYY-MM-dd"
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date2 = dateFormatter1.date(from:isoDate)!
        print(date2)
        let dayInWeek1 = dateFormatter.string(from: date2)
        
        let date = date2
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        let dayInWeek = dateFormatter2.string(from: date)
        print(dayInWeek)
        
        print("your next day is \(dayInWeek)")
        lblRarrivalDay.text = "\(dayInWeek)"
        arrMultiDay .insert("\(dayInWeek)", at: 1)
        multicityTableView .reloadData()
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    @objc func departBtnClicked(sender: UIButton){
   
        multiChoose = "depart"
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.multicityTableView)
        let indexPath = self.multicityTableView.indexPathForRow(at: buttonPosition)
        index = indexPath!.row
        print("index",index)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchCityVC") as? SearchCityViewController
        vc?.selectableCity = "departure"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    @objc func arriBtnClicked(sender: UIButton)
    {
        multiChoose = "arrive"
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.multicityTableView)
        let indexPath = self.multicityTableView.indexPathForRow(at: buttonPosition)
        index = indexPath!.row
        print("index",index)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchCityVC") as? SearchCityViewController
        vc?.selectableCity = "arrival"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func dateBtnClicked(sender: UIButton)
    {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.multicityTableView)
        let indexPath = self.multicityTableView.indexPathForRow(at: buttonPosition)
        index = indexPath!.row
        print("index",index)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomCalenderVC") as? CustomCalenderViewController
        vc?.selectableDate = "departureDate"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
    }
    
 
    @IBAction func onewayBtn(_ sender: Any)
    {
        wayType = "one"
        UserDefaults .standard .set("one", forKey: "wayType")
   
        multicityTableView.isHidden = true
        onewayScroll.isHidden = false
        roundTripScroll.isHidden = true
        onewayBtn.setTitleColor(.white, for: .normal)
        roundTripBtn.setTitleColor(.darkGray, for: .normal)
        multiCityBtn.setTitleColor(.darkGray, for: .normal)
        
        onewayBtn.backgroundColor = WebServicesUrl.appColor2
        roundTripBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
        multiCityBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
    }
    
    @IBAction func rondTRipBtn(_ sender: Any)
    {
        wayType = "two"
        UserDefaults .standard .set("two", forKey: "wayType")
   
        multicityTableView.isHidden = true
        onewayScroll.isHidden = true
        roundTripScroll.isHidden = false
        onewayBtn.setTitleColor(.darkGray, for: .normal)
        roundTripBtn.setTitleColor(.white, for: .normal)
        multiCityBtn.setTitleColor(.darkGray, for: .normal)
        roundTripBtn.backgroundColor = WebServicesUrl.appColor2
        onewayBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
        multiCityBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
    }
    
    @IBAction func multiCityBtn(_ sender: Any)
    {
        wayType = "multi"
        UserDefaults .standard .set("multi", forKey: "wayType")

        multicityTableView.isHidden = false
        onewayScroll.isHidden = true
        roundTripScroll.isHidden = true
        onewayBtn.setTitleColor(.darkGray, for: .normal)
        roundTripBtn.setTitleColor(.darkGray, for: .normal)
        multiCityBtn.setTitleColor(.white, for: .normal)
        multiCityBtn.backgroundColor = WebServicesUrl.appColor2
        onewayBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
        roundTripBtn.backgroundColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 0.2)
    }
}
