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
var searchedArray1 = [String]()
var searchedArray2 = [String]()

class SearchCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchBar: UITextField!
    var selectableCity: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
         txtSearchBar.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        self.getJSON ()
        //DselectedCityName DselectedCityCode
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
                    for item in airports {
                        cityName .append(item["CityName"] as! String)
                        cityCode .append(item["AirportCode"] as! String)
                    }
                    print(airports[0])
                    searchedArray1 = cityName
                    searchedArray2 = cityCode
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
        let label1 = cell.viewWithTag(2) as! UILabel // 1 is tag of first label;
        label1.text = searchedArray1[indexPath.row]
      //  cell.textLabel?.text = cityName[indexPath.row]
        
        return cell
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
        if textfield.text?.characters.count != 0 {
            for strCountry in cityName {
                let range = strCountry.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    searchedArray1.append(strCountry)
                }
            }
        } else {
            searchedArray1 = cityName
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
