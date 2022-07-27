//
//  FootprintResultObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import Foundation

class FootprintResultObservableObject: ObservableObject {
    init(with travelData: TravelData) {
        arrival = travelData.arrival ?? "Error"
        departure = travelData.departure ?? "Error"
        distance = travelData.distance
        transportationType = travelData.transportationType
        transportationMode = travelData.transportationMode
        footprint = travelData.footprint ?? 0
    }
    
    @Published var arrival = String()
    @Published var departure = String()
    @Published var distance = Double()
    @Published var transportationType: TransportationType = .SmallPetrolCar
    @Published var transportationMode: TransportationMode = .Vehicule
    @Published var footprint = Double()
}
