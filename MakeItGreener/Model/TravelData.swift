//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation
import MapKit

///Store data about the user journey
public struct TravelData {

    var arrivalTitle: String
    var arrivalSubtitle: String
    var departureTitle: String
    var departureSubtitle: String
    var distance: Double
    var transportationType: String
    var footprint: Double
    var timestamp: Date
    var imageName: String
}
