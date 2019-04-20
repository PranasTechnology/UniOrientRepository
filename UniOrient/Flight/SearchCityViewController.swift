//
//  SearchCityViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 03/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit
var cityName = [String]()
var cityCode = [String]()
var cityCountry = [String]()
var searchedArray1 = [String]()
var searchedArray2 = [String]()
var searchedArray3 = [String]()
var getAirports = [[String : Any]]()

class SearchCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchBar: UITextField!
    var selectableCity: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectableCity == "arrival"
        {
            lblTitle.text = "Arriving Airport"
        }
        else{
             lblTitle.text = "Departing Airport"
        }
       // txtSearchBar .becomeFirstResponder()
        txtSearchBar.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        self.getJSON ()
        //DselectedCityName DselectedCityCode
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func getJSON()
    {
        if let path = Bundle.main.path(forResource: "file1", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
      
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let airports = jsonResult["airports"] as? [[String:Any]]
                {
                    getAirports = airports
                  
                    for item in airports
                    {
                        cityName .append(item["CityName"] as! String)
                        cityCode .append(item["AirportCode"] as! String)
                        cityCountry.append(item["CountryName"] as! String)
                    }
                    print(airports[0])
                    searchedArray1 = cityName
                    searchedArray2 = cityCode
                    searchedArray3 = cityCountry

//                    searchedArray1 = Array(Set(searchedArray1))
//                    searchedArray2 = Array(Set(searchedArray2))
                    tableView.reloadData()
                }
            } catch {
                // handle error
            }
        }
    }
///Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return searchedArray1.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        let img1 = cell.viewWithTag(1) as! UIImageView
        let label1 = cell.viewWithTag(2) as! UILabel // 1 is tag of first label;
         let label2 = cell.viewWithTag(3) as! UILabel
        label1.text = searchedArray1[indexPath.row]
        label2.text = searchedArray2[indexPath.row] + " - " + searchedArray3[indexPath.row]
        img1.image = UIImage (named: "airplane")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(selectableCity == "departure")
        {
            UserDefaults.standard.set(searchedArray1[indexPath.row], forKey: "DselectedCityName")
           // UserDefaults.standard.set(searchedArray2[indexPath.row], forKey: "DselectedCityCode")
        }
        else
        {
            UserDefaults.standard.set(searchedArray1[indexPath.row], forKey: "AselectedCityName")
           // UserDefaults.standard.set(searchedArray2[indexPath.row], forKey: "AselectedCityCode")
        }
        self.navigationController?.popViewController(animated: true)
       
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        searchedArray1.removeAll()
        searchedArray2.removeAll()
        searchedArray3.removeAll()
        
        if textfield.text?.characters.count != 0 {
//            for strCountry in cityName
//            {
//                let range = strCountry.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
//
//                if range != nil {
//                    searchedArray1.append(strCountry)
//                }
//            }
        
            cityName.removeAll()
            cityName.removeAll()
            cityCountry.removeAll()
            //// new chanegs
            let namePredicate = NSPredicate(format: "CityName contains[c] %@",textfield.text!)
            
            let filteredArray = getAirports.filter { namePredicate.evaluate(with: $0) }
            
            print("names = \(filteredArray)")
            for item in filteredArray
            {
                cityName .append(item["CityName"] as! String)
                cityCode .append(item["AirportCode"] as! String)
                cityCountry.append(item["CountryName"] as! String)
            }
            searchedArray1 = cityName
            searchedArray2 = cityCode
            searchedArray3 = cityCountry
        } else {
            searchedArray1 = cityName
            searchedArray2 = cityCode
            searchedArray3 = cityCountry
           // searchedArray1 = Array(Set(searchedArray1))
        }
   
        print(searchedArray1.count)
        print(searchedArray2.count)
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
