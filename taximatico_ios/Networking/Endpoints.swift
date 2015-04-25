//
//  Endpoints.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

private let api_base = "http://api.taximatico.mx"
private let user_domain_path = "/users"

enum UserDomainEndpoint: String {
    case Registrations = "/registrations"
    case CodeVerification = "/verification_codes/check"
    
    func URL() -> NSURL {
        return NSURL(string: "\(api_base)\(user_domain_path)\(self.rawValue)")!
    }
}