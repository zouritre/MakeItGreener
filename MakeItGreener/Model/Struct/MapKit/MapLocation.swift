//
//  MapLocation.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 13/07/2022.
//

import Foundation
import MapKit

struct MapLocation: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    let name: LocationLabel
    
    init(id: UUID = UUID(), lat: Double, long: Double, name: LocationLabel) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.name = name
    }
}
