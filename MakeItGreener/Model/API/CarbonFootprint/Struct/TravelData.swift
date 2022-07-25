//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation

///Store data about the user journey
struct TravelData {
    var arrival: String?
    var departure: String?
    var distance: Double
    var transportationType: TransportationType
    var transportationMode: TransportationMode
    var footprint: Double?
}
