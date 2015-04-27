//
//  Driver.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

struct Location {
    var lat: Float?
    var long: Float?
}

struct Driver {
    var id: Int?
    var name: String?
    var taxiId: Int?
    var location: Location?
}