//
//  TXNetworking.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case OPTIONS    = "OPTIONS"
    case GET        = "GET"
    case HEAD       = "HEAD"
    case POST       = "POST"
    case PUT        = "PUT"
    case PATCH      = "PATCH"
    case DELETE     = "DELETE"
    case TRACE      = "TRACE"
    case CONNECT    = "CONNECT"
}

let URLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

func requestWithURL(url: NSURL?, method: HTTPMethod = .GET, customHeaders: [String:String] = ["":""]) -> NSMutableURLRequest? {
    if let url = url {
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = method.rawValue
        for element in customHeaders {
            request.setValue(element.1, forHTTPHeaderField: element.0)
        }
        
        return request
    }
    
    return nil
}

func dataFromJSON(json: [String:AnyObject]) -> NSData? {
    var dataError: NSError?
    let data = NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted, error: &dataError)
    
    if let error = dataError {
        return nil
    }
    
    return data
}

func JSONFromData(data: NSData) -> [String:AnyObject]? {
    var jsonError: NSError?
    let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &jsonError) as? [String:AnyObject]
    
    if let json = json where jsonError == nil {
        return json
    }
    
    return nil
}

func api_sendRegistrationRequest(phoneNumber ph: String, completionHandler: ((Bool) -> Void)?) {
    TXNetworkActivityIndicator.showNetworkActivityIndicator()
    
    let info = [
        "user": [
            "phone_number": ph
        ]
    ]
    
    let request = requestWithURL(
        UserDomainEndpoint.Registrations.URL(),
        method: .POST,
        customHeaders: ["Content-Type":"application/json"]
    )
    request!.HTTPBody = dataFromJSON(info)
    
    let dataTask = URLSession.dataTaskWithRequest(request!, completionHandler: { data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if error != nil {
            tx_executeOnMainThread(false, completionHandler)
        } else {
            if let json = JSONFromData(data) {
                tx_executeOnMainThread(string(json, "status") == "ok" ? true : false, completionHandler)
            }
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
    
    let request = requestWithURL(
        UserDomainEndpoint.CodeVerification.URL(),
        method: .POST,
        customHeaders: ["Content-Type":"application/json"]
    )
    request!.HTTPBody = dataFromJSON(info)
    
    let dataTask = URLSession.dataTaskWithRequest(request!, completionHandler: {data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if error != nil {
            tx_executeOnMainThread(false, nil, completionHandler)
        } else {
            if let json    = JSONFromData(data) {
                tx_executeOnMainThread(string(json, "status") == "ok" ? true : false, string(json, "authentication_token")!, completionHandler)
            }
        }
    })
    
    dataTask.resume()
}


func api_getDrivers(completionHandler: (([Driver]?) -> Void)?) {
    TXNetworkActivityIndicator.showNetworkActivityIndicator()
    
    let info = [
        "latitude" : "19.264987",
        "longitude" : "-103.710863"
    ]
    
    let request = requestWithURL(
        UserDomainEndpoint.Drivers.URL().tx_URLWithParams(info),
        method: .GET,
        customHeaders: ["X-AUTHENTICATION-TOKEN": "389c6bd0b49d72245e51a0deba266801"]
    )
    
    let dataTask = URLSession.dataTaskWithRequest(request!, completionHandler: { data, response, error in
        TXNetworkActivityIndicator.hideNetworkActivityIndicator()
        
        if error != nil {
            println(error)
            tx_executeOnMainThread(nil, completionHandler)
        } else {
            let json = JSONFromData(data)
            
            if let
                status      = string(json!, "status"),
                driversList = array(json!, "drivers") where status == "ok" {
                    var drivers = [Driver]()
                    
                    for driver in driversList {
                        if let newDriver = Driver.fromJSON(toDict(driver)!) {
                            drivers.append(newDriver)
                        }
                    }
                    
                    tx_executeOnMainThread(drivers, completionHandler)
            }else{
                tx_executeOnMainThread(nil, completionHandler)
            }
        }
    })
    
    dataTask.resume()
}