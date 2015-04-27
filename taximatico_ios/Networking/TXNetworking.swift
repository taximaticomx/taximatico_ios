//
//  TXNetworking.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

func api_sendRegistrationRequest(phoneNumber ph: String, completionHandler: ((Bool) -> Void)?) {
    TXNetworkActivityIndicator.showNetworkActivityIndicator()
    
    let info = [
        "user": [
            "phone_number": ph
        ]
    ]
    
    var jsonError: NSError?
    let json = NSJSONSerialization.dataWithJSONObject(info, options: .PrettyPrinted, error: &jsonError)
    
    var request = NSMutableURLRequest(URL: UserDomainEndpoint.Registrations.URL())
    request.HTTPMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = json
    
    let dataTask = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithRequest(request, completionHandler: { data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if let handler = completionHandler where error != nil {
            dispatch_async(dispatch_get_main_queue()) {
                handler(false)
            }
        }
        
        var dictError: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &dictError) as? [String:String]
        
        if let
            json    = jsonDict,
            handler = completionHandler {
                dispatch_async(dispatch_get_main_queue(), {
                    handler(json["status"] == "ok" ? true : false)
                })
        }
    })
    
    dataTask.resume()
}

func api_sendVerificationCode(verificationCode code: String, completionHandler: ((Bool, String?) -> Void)?) {
    TXNetworkActivityIndicator.showNetworkActivityIndicator()
    
    
    let info = ["verification_code" : [
        "code" : code
        ]
    ]
    
    var jsonError: NSError?
    let jsonData = NSJSONSerialization.dataWithJSONObject(info, options: .PrettyPrinted, error: &jsonError)
    
    var request = NSMutableURLRequest(URL: UserDomainEndpoint.CodeVerification.URL())
    request.HTTPMethod = "POST"
    request.HTTPBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let dataTask = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithRequest(request, completionHandler: {data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if let handler = completionHandler where error != nil {
            dispatch_async(dispatch_get_main_queue()) {
                handler(false, nil)
            }
        }
        
        var dictError: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &dictError) as? [String:String]
        
        if let
            json    = jsonDict,
            handler = completionHandler {
                dispatch_async(dispatch_get_main_queue(), {
                    handler(json["status"] == "ok" ? true : false, json["authentication_token"])
                })
        }
    })
    
    dataTask.resume()
    
}


func api_getDrivers(completionHandler: (([Driver]?) -> Void)?) {
    TXNetworkActivityIndicator.showNetworkActivityIndicator()
    
    let info = [
        "authentication_token" : "389c6bd0b49d72245e51a0deba266801", //currentSession.token,
        "latitude" : "19.264987",
        "longitude" : "-103.710863"
    ]
    
    var request = NSURLRequest(URL: UserDomainEndpoint.Drivers.URL().tx_URLWithParams(info)!)
    
    let dataTask = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithRequest(request, completionHandler: { data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if let errorHandler = completionHandler where error != nil {
            dispatch_async(dispatch_get_main_queue()) {
                errorHandler(nil)
            }
        }
        
        var dictError: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &dictError) as? [String:AnyObject]
        
        if let
            status      = jsonDict!["status"] as? String,
            driversList = jsonDict!["drivers"] as? [[String:AnyObject]],
            handler     = completionHandler where status == "ok" {
                var drivers = [Driver]()
                
                for driver in driversList {
                    if let newDriver = Driver.fromJSON(driver) {
                        drivers.append(newDriver)
                    }
                }
                
                handler(drivers)
        }else{
            if let errorHandler = completionHandler {
                errorHandler(nil)
            }
        }
    })
    
    dataTask.resume()
}