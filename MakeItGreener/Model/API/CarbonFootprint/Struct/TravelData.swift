//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation
import MapKit

///Store data about the user journey
struct TravelData {
    var arrival: MKLocalSearchCompletion?
    var departure: MKLocalSearchCompletion?
    var distance: Double
    var transportationType: TransportationType
    var transportationMode: TransportationMode
    var footprint: Double?
}
