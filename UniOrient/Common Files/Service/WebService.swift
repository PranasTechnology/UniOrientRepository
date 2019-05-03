//
//  WebService.swift
//  TripArcher
//
//  Created by APPLE on 19/11/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import UIKit

class WebService {
    
    func HTTP_POST_WebServiceMethod_Flight(mainURL:String,suffix : String , parameterDict : [String:String],completion:@escaping (_ Data:Any,_ IsSuccess:Bool) -> ())
    {
    
        var parameters = ""
        for (key,value) in parameterDict {
            parameters.append(key + "=" + value + "&")
        }
        parameters.remove(at: parameters.index(parameters.endIndex, offsetBy: -1))
        let soapLenth = String(parameters.count)
    
        let theUrlString = mainURL + "/" + suffix
        let theURL = URL(string: theUrlString)
        
        var mutableR = URLRequest.init(url: theURL!)
        mutableR.httpMethod = "POST"
        mutableR.allHTTPHeaderFields = ["Content-Type":"application/x-www-form-urlencoded","Content-Length":soapLenth]
        mutableR.httpBody = parameters.data(using: String.Encoding.utf8)
        
        mutableR.timeoutInterval = 35
        mutableR.allowsCellularAccess = true
        
        
        let manager = AFHTTPRequestOperation(request: mutableR as URLRequest)
        manager.setCompletionBlockWithSuccess({ (operation : AFHTTPRequestOperation, responseObject : Any) -> Void in
            let responseData = responseObject as! Data
            let stringFromData = String(data: responseData, encoding: .utf8)
            
            //            var strDic = String(describing: stringFromData)
            let strDic = String(stringFromData!.dropFirst(75))
            
            let finalStr = strDic.dropLast(9) as NSString
                      print(finalStr)
            
            if let FinalData = finalStr.data(using: String.Encoding.utf8.rawValue) {
                if let JsonDict:[String:AnyObject] = try? JSONSerialization.jsonObject(with: FinalData, options: .mutableContainers) as! [String:AnyObject] {
                    completion(JsonDict,true)
                }
                else {
                    completion([],false)
                }
            }
            else {
                completion([],false)
            }
            
        }, failure: { (operation : AFHTTPRequestOperation, error : Error) -> Void in
            
            print(error, terminator: "")
            
            completion([:],false)
            
        })
        
        manager.start()
    }
    
    
    func HTTP_POST_WebServiceMethod_Hotel(mainURL:String,suffix : String , parameterDict : [String:String],completion:@escaping (_ Data:Any,_ IsSuccess:Bool) -> ())
    {
        
        //Part 1
        var parameters = ""
        for (key,value) in parameterDict {
            parameters.append(key + "=" + value + "&")
        }
        parameters.remove(at: parameters.index(parameters.endIndex, offsetBy: -1))
        let soapLenth = String(parameters.count)
        
        
        //Part 2
        let theUrlString = mainURL + "/" + suffix
        let theURL = URL(string: theUrlString)
        
        //Part 3
        var mutableR = URLRequest.init(url: theURL!)
        mutableR.httpMethod = "POST"
        mutableR.allHTTPHeaderFields = ["Content-Type":"application/x-www-form-urlencoded","Content-Length":soapLenth]
        mutableR.httpBody = parameters.data(using: String.Encoding.utf8)
        
        mutableR.timeoutInterval = 35
        mutableR.allowsCellularAccess = true
        
        //Part 4
        let manager = AFHTTPRequestOperation(request: mutableR as URLRequest)
        
        manager.setCompletionBlockWithSuccess({ (operation : AFHTTPRequestOperation, responseObject : Any) -> Void in

            let responseData = responseObject as! Data
            let stringFromData = String(data: responseData, encoding: .utf8)
            
//            var strDic = String(describing: stringFromData)
            let strDic = String(stringFromData!.dropFirst(75))

            let finalStr = strDic.dropLast(9) as NSString
//            print(finalStr)
            
            if finalStr == "" {
                print("the finalStr after dropping is empty")
                let myArr : [String] = ["No data for your search!!!"]
                completion(myArr,false)
            }else{
                if let FinalData = finalStr.data(using: String.Encoding.utf8.rawValue) {
                    if let JsonArr:[[String:AnyObject]] = try? JSONSerialization.jsonObject(with: FinalData, options: .mutableContainers) as! [[String:AnyObject]] {
                        completion(JsonArr,true)
                    }
                    else {
                        print("Failure from 1...")
//                        completion([],false)
                        let myArr : [String] = ["Please try after sometime!!!"]
                        completion(myArr,false)
                    }
                }
                else {
                    print("Failure from 2...")
//                    completion([],false)
                    let myArr : [String] = ["Please try later!!!"]
                    completion(myArr,false)
                }
            }
            
        }, failure: { (operation : AFHTTPRequestOperation, error : Error) -> Void in
            
            print("Failure from 3 : ",error, terminator: "")
            
//            completion([],false)
            let myArr : [String] = ["Server Error.Try After sometimes!!!"]
            completion(myArr,false)
            
        })
        
        manager.start()
    }
    
    
    
    
    //MARK:- HTTP POST ----------- Profile
    func HTTP_POST_WebServiceMethod_Profile(mainURL:String,suffix : String , parameterDict : [String:String],completion:@escaping (_ Data:Any,_ IsSuccess:Bool) -> ())
    {
        
    
        var parameters = ""
        for (key,value) in parameterDict {
            parameters.append(key + "=" + value + "&")
        }
        parameters.remove(at: parameters.index(parameters.endIndex, offsetBy: -1))
        let soapLenth = String(parameters.count)
        
        
        
        let theUrlString = mainURL + "/" + suffix
        let theURL = URL(string: theUrlString)
        
       
        var mutableR = URLRequest.init(url: theURL!)
        mutableR.httpMethod = "POST"
        mutableR.allHTTPHeaderFields = ["Content-Type":"application/x-www-form-urlencoded","Content-Length":soapLenth]
        mutableR.httpBody = parameters.data(using: String.Encoding.utf8)
        
        mutableR.timeoutInterval = 35
        mutableR.allowsCellularAccess = true
        
       
        let manager = AFHTTPRequestOperation(request: mutableR as URLRequest)
        
        manager.setCompletionBlockWithSuccess({ (operation : AFHTTPRequestOperation, responseObject : Any) -> Void in
            
            let responseData = responseObject as! Data
            let stringFromData = String(data: responseData, encoding: .utf8)
            
            //            var strDic = String(describing: stringFromData)
            let strDic = String(stringFromData!.dropFirst(75))
            
            let finalStr = strDic.dropLast(9) as NSString
            print(finalStr)
            
            
            /*
            if let FinalData = finalStr.data(using: String.Encoding.utf8.rawValue) {
                if let JsonDict:[String:AnyObject] = try? JSONSerialization.jsonObject(with: FinalData, options: .mutableContainers) as! [String:AnyObject] {
                    completion(JsonDict,true)
                }
                else {
                    completion([],false)
                }
            }
            else {
                completion([],false)
            } */
            
            let JsonDict:[String:AnyObject] = ["Result":finalStr]
            completion(JsonDict,true)
            
            
        }, failure: { (operation : AFHTTPRequestOperation, error : Error) -> Void in
            
            print(error, terminator: "")
            
            completion([:],false)
            
        })
        
        manager.start()
    }
 
}
