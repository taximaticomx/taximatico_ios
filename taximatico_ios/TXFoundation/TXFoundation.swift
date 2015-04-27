//
//  TXFoundation.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

let userDefaults = NSUserDefaults.standardUserDefaults()

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

// MARK: - Get

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


// MARK: - Set

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