//
//  TXDictionary.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

extension Dictionary {
    func tx_URLEncodedString() -> String {
        var pairs = Array<String>()
        
        for element in self {
            let queryPair = "\(tx_URLEncode((element.0 as? String)!))=\(tx_URLEncode((element.1 as? String)!))"
            
            pairs.append(queryPair)
        }
        
        return join("&", pairs)
    }
}

func tx_URLEncode(o: AnyObject) -> String {
    let string = o as? String
    if let s = string {
        return s.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }
    
    return ""
}