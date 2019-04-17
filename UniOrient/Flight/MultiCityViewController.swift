//
//  MultiCityViewController.swift
//  UniOrient
//
//  Created by Pranas on 16/04/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class MultiCityViewController: UIViewController {
  @IBOutlet var multiCityBottomView: UIView!
    
    @IBOutlet weak var travellerView: UIView!
    @IBOutlet weak var classChooseView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var multiTableView: UITableView!
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
  
    override func viewDidLoad() {
        super.viewDidLoad()

//        classChooseView .isHidden = true
//        travellerView .isHidden = true
        
        UserDefaults.standard.set("", forKey: "DselectedCityName")
        UserDefaults.standard.set("", forKey: "DselectedCityCode")
        UserDefaults.standard.set("", forKey: "AselectedCityName")
        UserDefaults.standard.set("", forKey: "AselectedCityCode")
        UserDefaults.standard.set("", forKey: "selectedDeptDate")
        UserDefaults.standard.set("", forKey: "selectedArrDate")
        UserDefaults.standard.set("", forKey: "selectedDeptDay")
        UserDefaults.standard.set("", forKey: "selectedArrDay")
        // UserDefaults.standard.set("twoway", forKey: "wayType")
        UserDefaults.standard.set("one", forKey: "wayType")
//        classTableView.layer.cornerRadius = 5.0
//        travellerView.layer.cornerRadius = 5.0
//        className = ["Economy Class","Premium Economy Class","Business Class","First Class"]
//        arrMultiTitle = ["   Flight 1   ","   Flight 2   ","   Flight 3   "]
//        arrMultiDepartCode = ["Source","Source","Source"]
//        arrMultiDepartCity = ["Select City","Select City","Select City"]
//        arrMultiArriCode = ["Destination","Destination","Destination"]
//        arrMultiArriCity = ["Select City","Select City","Select City"]
//        //        [arrFromCityCode addObject:@"Source"];
//        //        [arrFromCityName addObject:@"Select City"];
//        //        [arrToCityCode addObject:@"Destination"];
//        //        [arrToCityName addObject:@"Select City"];
//        //
//        arrAdult = ["1","2","3","4","5","6","7","8","9","10"]
//        arrChild = ["0","1","2","3","4","5","6","7","8","9"]
//        arrInfant = ["0","1","2","3","4","5","6","7","8","9"]
//        

    }
    
    ///////////// tableView DataSource - Delegate Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == multiTableView)
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
        if(tableView == multiTableView)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
            
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! multiTableViewCell
            //            cell.cellDelegate = self as YourCellDelegate
            //            cell.departBtn.tag = indexPath.row
            
            let title = cell.viewWithTag(1) as! UILabel
            let departCode = cell.viewWithTag(4) as! UILabel
            let departCity = cell.viewWithTag(5) as! UILabel
            let arriCode = cell.viewWithTag(6) as! UILabel
            let arriCity = cell.viewWithTag(7) as! UILabel
            let departDate = cell.viewWithTag(8) as! UILabel
            let departDay = cell.viewWithTag(9) as! UILabel
            let departBtn = cell.viewWithTag(11) as! UIButton
            //            let ArriBtn = cell.viewWithTag(22) as! UIButton
            //            let DateBtn = cell.viewWithTag(33) as! UIButton
            
            title.text = arrMultiTitle[indexPath.row]
            departCode.text = arrMultiDepartCode[indexPath.row]
            departCity.text = arrMultiDepartCity[indexPath.row]
            arriCode.text = arrMultiArriCode[indexPath.row]
            arriCity.text = arrMultiArriCity[indexPath.row]
            //            departDate.text = arrMultiDate[indexPath.row]
            //            departDay.text = arrMultiDay[indexPath.row]
            //
//            departBtn.addTarget(self, action: #selector(departBtnClicked(sender:)), for: .touchUpInside)
            
            //            ArriBtn.addTarget(self, action:#selector(arriBtnClicked(sender:)), for: .touchUpInside)
            //            DateBtn.addTarget(self, action:#selector(dateBtnClicked(sender:)), for: .touchUpInside)
            //            departBtn.tag = indexPath.row
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
        if(tableView == multiTableView)
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
        if(tableView == multiTableView)
        {
            print("HELLO")
        }
        else
        {
//            if(wayType == "one")
//            {
//                txtClass . text = className[indexPath.row]
//            }else{
//                RtxtClass . text = className[indexPath.row]
//            }
            
            classChooseView .isHidden = true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
