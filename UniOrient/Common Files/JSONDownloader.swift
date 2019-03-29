//
//  JsonDownloader.swift
//  NewProject
//
//  Created by Mangai S on 13/12/17.
//  Copyright © 2017 Mangai S. All rights reserved.
//

import Foundation
import Alamofire

struct JSONDownloader{
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
           
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.Error(.requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                            DispatchQueue.main.async {
                                completion(.Success(json))
                            }
                        }
                    } catch {
                        completion(.Error(.jsonConversionFailure))
                    }
                } else {
                    completion(.Error(.invalidData))
                }
            } else {
                completion(.Error(.responseUnsuccessful))
               
            }
        }
        return task
    }
}
//http://staging2.damacproperties.com/en/webservices/projects

enum Result <T>{
    case Success(T)
    case Error(ApiError)
}

enum ApiError:String,Error,CustomStringConvertible {
    case requestFailed = "requestFailed"
    case jsonConversionFailure = "jsonConversionFailure"
    case invalidData = "invalidData"
    case responseUnsuccessful = "responseUnsuccessful"
    case invalidURL = "invalidURL"
    case jsonParsingFailure = "jsonParsingFailure"
    var description:String{
        return self.rawValue
    }
}
//////////////////////////////////////////////////////rekha Updates

func AlamofireRequest(URL: String,params: Dictionary<String, Any>) -> Dictionary<String, Any> {
    
    var dic = Dictionary<String, Any>()
    // Fetch Request
    Alamofire.request("http://mobileapi.shioktrip.com/FlightService.asmx/FlightResult?", method: .get, parameters: params)
        .validate(statusCode: 200..<300)
        .responseString { response in
            if (response.result.error == nil) {
                // dic = response
                debugPrint("HTTP Response Body: \(response)")
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
            }
    }
    return dic
}
