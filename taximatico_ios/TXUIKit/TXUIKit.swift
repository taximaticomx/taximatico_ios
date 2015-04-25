//
//  TXUIKit.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import UIKit

class TXNetworkActivityIndicator {
    static var number: Int = 0
    
    class func showNetworkActivityIndicator() {
        number++
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    class func hideNetworkActivityIndicator() {
        if number > 0 {
            number--
        }
        
        if number == 0 {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
