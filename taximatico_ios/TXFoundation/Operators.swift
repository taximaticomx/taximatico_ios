//
//  Operators.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/27/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

infix operator >>>= {}
func >>>= <A, B> (optional: A?, f: A -> B?) -> B? {
    return flatten(optional.map(f))
}

infix operator <*> { associativity left precedence 150 }
func <*><A, B>(l: (A -> B)?, r: A?) -> B? {
    if let
        l1 = l,
        r1 = r {
            return l1(r1)
    }
    
    return nil
}