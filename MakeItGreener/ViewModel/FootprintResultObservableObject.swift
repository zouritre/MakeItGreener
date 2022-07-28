//
//  FootprintResultObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import Foundation
import MapKit
import SwiftUI

class FootprintResultObservableObject: ObservableObject {
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    private var footprintSeverityHigh: [Color] = [.red, .yellow, .green]
    private var footprintSeverityMedium: [Color] = [.yellow, .green, .red]
    private var footprintSeverityLow: [Color] = [.green, .yellow, .red]
    
    init(with travelData: TravelData) {
        arrival = travelData.arrival ?? MKLocalSearchCompletion()
        departure = travelData.departure ?? MKLocalSearchCompletion()
        distance = numberFormatter.string(from: travelData.distance as NSNumber) ?? "Error"
        transportationType = travelData.transportationType
        transportationMode = travelData.transportationMode
        footprint = numberFormatter.string(from: travelData.footprint as? NSNumber ?? 0) ?? "Error"
        
        updateGradient(with: travelData.footprint ?? 0)
    }
    
    @Published var arrival = MKLocalSearchCompletion()
    @Published var departure = MKLocalSearchCompletion()
    @Published var distance = String()
    @Published var transportationType: TransportationType = .SmallPetrolCar
    @Published var transportationMode: TransportationMode = .Vehicule
    @Published var footprint = String()
    @Published var footprintSeverityIndicator: [Color] = [.red, .yellow, .green]
    @Published var gradientStartRadius: CGFloat = 0
    @Published var gradientEndRadius: CGFloat = 500
    
    private func updateGradient(with footprint: Double) {
        switch footprint {
        case 0..<100:
            footprintSeverityIndicator = footprintSeverityLow
        case 100..<300:
            footprintSeverityIndicator = footprintSeverityMedium
            gradientEndRadius = 400
            gradientStartRadius = 50
        case 300...:
            footprintSeverityIndicator = footprintSeverityHigh
        default: return
        }
    }
}
