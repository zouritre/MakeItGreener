//
//  FootprintResultObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import Foundation
import MapKit

class FootprintResultObservableObject: ObservableObject {
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    init(with travelData: TravelData) {
        arrival = travelData.arrival ?? MKLocalSearchCompletion()
        departure = travelData.departure ?? MKLocalSearchCompletion()
        distance = numberFormatter.string(from: travelData.distance as NSNumber) ?? "Error"
        transportationType = travelData.transportationType
        transportationMode = travelData.transportationMode
        footprint = numberFormatter.string(from: travelData.footprint as? NSNumber ?? 0) ?? "Error"
    }
    
    @Published var arrival = MKLocalSearchCompletion()
    @Published var departure = MKLocalSearchCompletion()
    @Published var distance = String()
    @Published var transportationType: TransportationType = .SmallPetrolCar
    @Published var transportationMode: TransportationMode = .Vehicule
    @Published var footprint = String()
}
