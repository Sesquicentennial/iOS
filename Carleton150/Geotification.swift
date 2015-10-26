//
//  geoFence.swift
//  Carleton150
//
//  Created by Sherry Gu on 10/22/15.
//  Copyright © 2015 edu.carleton.carleton150. All rights reserved.
//

import Foundation

import UIKit
import MapKit
import CoreLocation

let kGeotificationLatitudeKey = "latitude"
let kGeotificationLongitudeKey = "longitude"
let kGeotificationRadiusKey = "radius"
let kGeotificationIdentifierKey = "identifier"
let kGeotificationNoteKey = "note"
let kGeotificationEventTypeKey = "eventType"

enum EventType: Int {
    case OnEntry = 0
    case OnExit
}

class Geotification: NSObject, NSCoding, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    //var note: String
    //var eventType: EventType
    
    //var title: String {
    //    if note.isEmpty {
    //        return "No Note"
    //    }
    //    return note
   // }

    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        //self.note = note
        //self.eventType = eventType
    }
    
    // MARK: NSCoding
    
    required init(coder decoder: NSCoder) {
        let latitude = decoder.decodeDoubleForKey(kGeotificationLatitudeKey)
        let longitude = decoder.decodeDoubleForKey(kGeotificationLongitudeKey)

        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        radius = decoder.decodeDoubleForKey(kGeotificationRadiusKey)
        identifier = decoder.decodeObjectForKey(kGeotificationIdentifierKey) as! String
        //note = decoder.decodeObjectForKey(kGeotificationNoteKey) as! String
        //eventType = EventType(rawValue: decoder.decodeIntegerForKey(kGeotificationEventTypeKey))!
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeDouble(coordinate.latitude, forKey: kGeotificationLatitudeKey)
        coder.encodeDouble(coordinate.longitude, forKey: kGeotificationLongitudeKey)
        coder.encodeDouble(radius, forKey: kGeotificationRadiusKey)
        coder.encodeObject(identifier, forKey: kGeotificationIdentifierKey)
        //coder.encodeObject(note, forKey: kGeotificationNoteKey)
        //coder.encodeInt(Int32(eventType.rawValue), forKey: kGeotificationEventTypeKey)
    }
}

