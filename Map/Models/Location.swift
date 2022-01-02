//
//  Location.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 31/12/2564 BE.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Equatable {
    
    var id: String {
        name + cityName
    }
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
    
}
