//
//  TXUIKit.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import UIKit

func showNetworkActivityIndicator() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
}

func hideNetworkActivityIndicator() {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
}