//
//  Constant.swift
//  TakeMyTravel
//
//  Created by apple1 on 07/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit
import Alamofire

class Constant: NSObject
{
     static let flightUrl = "http://192.168.1.3:2310/FlightService.asmx/FlightResult?"
   //  static let flightUrl = "http://mobileapi.shioktrip.com/FlightService.asmx/FlightResult?"
    
    static func AlamofireRequest(URL: String,params: [String: Any]) -> [[String: Any]] {
        var dic  = [[String: Any]] ()
        // Fetch Request
        Alamofire.request(URL, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                if (response.result.error == nil)
                {
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    var strDic = String(jsonString!.dropFirst(75))
                    strDic = String(strDic.dropLast(9))
                    let dictonary = convertStringToDictionary(json: strDic)
                    if let myDictionary = dictonary
                    {
                        let dict = myDictionary["FlightResult"]
                        print(dict!)
                        if let array = dict as? [[String: Any]] {
                            //If you want array of task id you can try like
                            //                            dic = array.compactMap { $0["airname"] as? String }
                            dic = array
                           // print(dic)
                        }
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        return dic
    }
    
}

func convertStringToDictionary(json: String) -> NSDictionary? {
    var dictonary:NSDictionary?
    if let data = json.data(using: String.Encoding.utf8) {
        do {
            dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    return dictonary
}

extension UIColor
{
    class func AppBlueColor() -> UIColor
    {
        return UIColor(red: 1.0/255.0, green: 113.0/255.0, blue: 175.0/255.0, alpha:1.0)
    }
    
    class func AppMaroonColor() -> UIColor
    {
        return UIColor(red: 174.0/255.0, green: 22.0/255.0, blue: 10.0/255.0, alpha:1.0)
    }
}
func getDayOfWeek(_ today:String) -> Int? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd MMM, yyyy"//"yyyy/MMM/dd"//18 January, 2019
    guard let todayDate = formatter.date(from: today) else { return nil }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
}
