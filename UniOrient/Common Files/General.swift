//
//  General.swift
//  TripArcher
//
//  Created by APPLE on 27/11/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

import UIKit

extension Thread {
    class func printCurrent() {
        print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Activity Indicator
var loadingView = UIView()
var container = UIView()
var activityIndicator = UIActivityIndicatorView()
func showLoading() {
    
    let win:UIWindow = UIApplication.shared.delegate!.window!!
    loadingView = UIView(frame: win.frame)
    loadingView.tag = 48 //any no.
    loadingView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
//    loadingView.backgroundColor = UIColor.red
    win.addSubview(loadingView)
    
    container = UIView(frame: CGRect(x: 0, y: 0, width: win.frame.width/3, height: win.frame.width/3))
    container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
//    container.backgroundColor = UIColor.green
    container.layer.cornerRadius = 10.0
    container.layer.borderColor = UIColor.gray.cgColor
    container.layer.borderWidth = 0.5
    container.clipsToBounds = true
    container.center =  loadingView.center
    
    
    activityIndicator.frame = CGRect(x: 0, y: 0, width :win.frame.width/5, height : win.frame.width/5)
    activityIndicator.style = .whiteLarge
    activityIndicator.center =  loadingView.center
    
    
    loadingView.addSubview(container)
    loadingView.addSubview(activityIndicator)
    
    activityIndicator.startAnimating()
    
}

func hideLoading(){
    DispatchQueue.main.async() {
        UIView.animate(withDuration: 0.0, delay: 0.2, options: .curveEaseOut, animations: {
            container.alpha = 0.0
            loadingView.alpha = 0.0
            activityIndicator.stopAnimating()
        }, completion: { finished in
            activityIndicator.removeFromSuperview()
            container.removeFromSuperview()
            loadingView.removeFromSuperview()
            let win:UIWindow = UIApplication.shared.delegate!.window!!
            let removeView  = win.viewWithTag(48)
            removeView?.removeFromSuperview()
        })
        
    }
}

func SaveLoginResponseWithStruct(Struct:LoginResponse) {
    
    var SaveDict = [String:String]()
    SaveDict = ["UserSK":"\(Struct.UserSK!)",
        "Name":"\(Struct.Name!)",
        "PhoneNo":"\(Struct.PhoneNo!)"]
    
    let Defaults = UserDefaults.standard
    let data = try? JSONSerialization.data(withJSONObject: SaveDict, options: .prettyPrinted)
    Defaults.set(data, forKey: "LoginResponse")
    Defaults.synchronize()
}

func FetchLoginResponse() -> LoginResponse? {
    
    if UserDefaults.standard.value(forKey: "LoginResponse") != nil {
        
        if let ResponceDict:[String:AnyObject] = try! JSONSerialization.jsonObject(with:UserDefaults.standard.value(forKey: "LoginResponse") as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] {
            
            var LoginObj = LoginResponse()
            LoginObj.UserSK = "\(ResponceDict["UserSK"]!)"
            LoginObj.Name = "\(ResponceDict["Name"]!)"
            LoginObj.PhoneNo = "\(ResponceDict["PhoneNo"]!)"

            return LoginObj
        }
        else {
            
            return nil
        }
    }
    else {
        return nil
    }
}
func SaveLoginDetailsWithStruct(Struct:LoginDetails) {
    
    var aDict = [String:String]()
    aDict = ["Email":"\(Struct.Email!)",
        "Password":"\(Struct.Password!)"]
    
    let Defaults = UserDefaults.standard
    let data = try? JSONSerialization.data(withJSONObject: aDict, options: .prettyPrinted)
    Defaults.set(data, forKey: "LoginDetails")
    Defaults.synchronize()
}

func FetchLoginDetails() -> LoginDetails! {
    
    if UserDefaults.standard.value(forKey: "LoginDetails") != nil {
        if let LoginDetailsDict:[String:String] = try! JSONSerialization.jsonObject(with: UserDefaults.standard.value(forKey: "LoginDetails") as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:String] {

            var LoginObj = LoginDetails()
            LoginObj.Email = LoginDetailsDict["Email"]!
            LoginObj.Password = LoginDetailsDict["Password"]!
            return LoginObj
        }
        else {
            return nil
        }
    }
    else {
        return nil
    }
    
}
