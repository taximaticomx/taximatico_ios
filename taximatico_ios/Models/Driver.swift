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
    
    static func fromJSON(json: [String:AnyObject]) -> Driver? {
        let mkDriver = curry { id, name, taxiId in Driver(id: id, name: name, taxiId: taxiId) }
        
        return toDict(json) >>>= {
                mkDriver <*> int($0, "id")!
                        <*> string($0, "name")!
                        <*> int($0, "taxi_number")!
        }
    }
}

extension Driver: Printable {
    var description: String {
        get {
            return "\nDriver:\n\tId: \(self.id!)\n\tName: \(self.name!)\n\tTaxi ID: \(self.taxiId!)"
        }
    }
}
