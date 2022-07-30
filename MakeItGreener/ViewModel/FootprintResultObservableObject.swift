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
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .short
        
        return formatter
    }
    
    var travelData: TravelData
    var footprintSeverityHigh: [Color] = [.red, .yellow, .green]
    var footprintSeverityMedium: [Color] = [.yellow, .red, .green]
    var footprintSeverityLow: [Color] = [.green, .yellow, .red]
    
    init(with travelData: TravelData) {
        self.travelData = travelData
        arrival = travelData.arrival ?? MKLocalSearchCompletion()
        departure = travelData.departure ?? MKLocalSearchCompletion()
        distance = numberFormatter.string(from: travelData.distance as NSNumber) ?? "Error"
        transportationType = travelData.transportationType
        transportationMode = travelData.transportationMode
        footprint = numberFormatter.string(from: travelData.footprint as? NSNumber ?? 0) ?? "Error"
        timestamp = dateFormatter.string(from: .now)
        
        updateGradient(with: travelData.footprint ?? 0)
    }
    
    @Published var arrival = MKLocalSearchCompletion()
    @Published var departure = MKLocalSearchCompletion()
    @Published var distance = String()
    @Published var transportationType: TransportationType = .SmallPetrolCar
    @Published var transportationMode: TransportationMode = .Vehicule
    @Published var timestamp = String()
    @Published var footprint = String()
    @Published var footprintSeverityIndicator: [Color] = [.red, .yellow, .green]
    @Published var gradientStartRadius: CGFloat = 0
    @Published var gradientEndRadius: CGFloat = 500
    
    func updateGradient(with footprint: Double) {
        switch footprint {
        case 0..<100:
            footprintSeverityIndicator = footprintSeverityLow
        case 100..<300:
            footprintSeverityIndicator = footprintSeverityMedium
            gradientEndRadius = 300
            gradientStartRadius = 150
        case 300...:
            footprintSeverityIndicator = footprintSeverityHigh
        default: return
        }
    }
}
