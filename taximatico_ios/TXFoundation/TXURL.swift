//
//  TXURL.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

extension NSURL {
    func tx_URLWithParams(params: [String:String])-> NSURL? {
        return NSURL(string: "\(self)?\(params.tx_URLEncodedString())")
    }
}