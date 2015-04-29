//
//  Driver.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import Foundation

struct Location {
    var lat: Double?
    var lon: Double?
}

struct Driver {
    var id: Int?
    var name: String?
    var taxiId: Int?
    var location: Location?
    
    static func fromJSON(json: [String:AnyObject]) -> Driver? {
        let mkLocation = curry { lat, lon in Location(lat: lat, lon: lon) }
        let mkDriver = curry { id, name, taxiId, location in Driver(id: id, name: name, taxiId: taxiId, location: location) }
        
        let location = toDict(json["location"]!) >>>= {
            mkLocation <*> double($0, "latitude")!
                <*> double($0, "longitude")!
        }
        
        return toDict(json) >>>= {
            mkDriver <*> int($0, "id")!
                <*> string($0, "name")!
                <*> int($0, "taxi_number")!
                <*> location!
        }
    }
}

extension Driver: Printable {
    var description: String {
        get {
            return "\nDriver:\n\tId: \(self.id!)\n\tName: \(self.name!)\n\tTaxi ID: \(self.taxiId!)\n\tLocation: \(self.location!.lat!) \(self.location!.lon!)"
        }
    }
}
