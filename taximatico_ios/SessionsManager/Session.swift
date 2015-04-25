//
//  SessionsManager.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

let token_key = "TokenKey"

class Session {
    var token: String
    var valid: Bool {
        get {
            return count(token) > 9
        }
    }
    
    init() {
        token = user_defaults_get_string(token_key)
    }
    
    convenience init(token: String) {
        self.init()
        
        self.token = token
    }
    
    func save() -> Bool {
        return user_defaults_set_string(token_key, self.token)
    }
    
    func end() -> Bool {
        return user_defaults_set_string(token_key, nil)
    }
}

var currentSession: Session {
    get{
        return Session()
    }
}
