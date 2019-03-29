//
//  JSON Convertion.swift
//  TakeMyTravel
//
//  Created by apple1 on 03/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit

class JSON_Convertion: NSObject
{
    func readJson()-> Dictionary<String,Any> {
        var object1 :  [String: AnyObject] =  [String: AnyObject]()
        do {
            
            if let file = Bundle.main.url(forResource: "file1", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as?  [String: AnyObject] {
                  // object1 = object
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                   // print(object)
                } else {
                   // print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return object1
    }

}
