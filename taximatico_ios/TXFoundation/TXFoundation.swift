//
//  TXFoundation.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

let userDefaults = NSUserDefaults.standardUserDefaults()

// MARK: - Utilities

func tx_executeOnMainThread(block: (() -> ())?) {
    if let block = block {
        if NSThread.isMainThread() {
            block()
        } else {
            dispatch_sync(dispatch_get_main_queue(), block);
        }
    }
}

func tx_URLEncode(o: AnyObject) -> String {
    let string = o as? String
    if let s = string {
        return s.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }
    
    return ""
}


// MARK: - Functional stuff

func flatten<A>(x: A??) -> A? {
    if let y = x { return y }
    return nil
}


// MARK: - User Defaults Get

func user_defaults_get_string(key: String) -> String {
    let s = userDefaults.objectForKey(key) as? String
    if let s = s {
        return s
    }
    
    return ""
}

func user_defaults_get_bool(key: String) -> Bool {
    return userDefaults.boolForKey(key)
}

func user_defaults_get_integer(key: String) -> Int {
    return userDefaults.integerForKey(key)
}


// MARK: - User Defaults Set

func user_defaults_set_string(key: String, val: String?) -> Bool {
    userDefaults.setObject(val, forKey: key)
    return userDefaults.synchronize()
}

func user_defaults_set_bool(key: String, val: Bool) -> Bool {
    userDefaults.setBool(val, forKey: key)
    return userDefaults.synchronize()
}

func user_defaults_set_integer(key: String, val: Int) -> Bool {
    userDefaults.setInteger(val, forKey: key)
    return userDefaults.synchronize()
}


// MARL: - Casting

func toDict(x: AnyObject) -> [String:AnyObject]? {
    return x as? [String:AnyObject]
}


// MARK: - Getting Data From [String:AnyObject]s

func number(input: [NSObject:AnyObject], key: String) -> NSNumber? {
    return input[key] >>>= { $0 as? NSNumber }
}

func int(input: [NSObject:AnyObject], key: String) -> Int? {
    return number(input, key).map { $0.integerValue }
}

func string(input: [String:AnyObject], key: String) -> String? {
    return input[key] >>>= { $0 as? String }
}

func bool(input: [String:AnyObject], key: String) -> Bool? {
    return number(input, key).map { $0.boolValue }
}

func array(input: [String:AnyObject], key: String) -> [AnyObject]? {
    let maybeAny: AnyObject? = input[key]
    return maybeAny >>>= { $0 as? [AnyObject] }
}

func arrayOf<A>(input: [String:AnyObject], key: String) -> [A]? {
    let maybeAny: AnyObject? = input[key]
    return maybeAny >>>= { $0 as? [A] }
}

func something<A>(input: [String:AnyObject], key: String, type: A) -> A? {
    return input[key] >>>= { $0 as? A }
}


// MARK: - Currys

func curry<A, B, R> (f: (A, B) -> R) -> A -> B -> R {
    return { a in { b in f(a, b) } }
}

func curry<A, B, C, R> (f: (A, B, C) -> R) -> A -> B -> C -> R {
    return { a in { b in { c in f(a, b, c) } } }
}

func curry<A, B, C, D, R> (f: (A, B, C, D) -> R) -> A -> B -> C -> D -> R {
    return { a in { b in { c in { d in f(a, b, c, d) } } } }
}