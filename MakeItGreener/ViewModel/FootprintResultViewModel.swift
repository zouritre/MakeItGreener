//
//  FootprintResultObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import Foundation
import MapKit
import SwiftUI

class FootprintResultViewModel {
    
    init() {
        self.arrivalTitle = "Paris"
        self.arrivalSubtitle = "10ème arrondissement"
        self.departureTitle = "Lyon"
        self.departureSubtitle = "9ème arrondissement"
        self.distance = "400"
        self.transportationType = "Small petrol car"
        self.transportationMode = "Vehicle"
        self.footprint = "123"
        self.timestamp = "20/07/2022"
        self.imageName = "car"
    }
    
    convenience init(with travelData: TravelData) {
        self.init()
        
        self.arrivalTitle = travelData.arrivalTitle
        self.arrivalSubtitle = travelData.arrivalSubtitle
        self.departureTitle = travelData.departureTitle
        self.departureSubtitle = travelData.departureSubtitle
        self.distance = numberFormatter.string(from: travelData.distance as NSNumber) ?? "Error"
        self.transportationType = travelData.transportationType
        self.footprint = numberFormatter.string(from: travelData.footprint as NSNumber) ?? "Error"
        self.timestamp = dateFormatter.string(from: travelData.timestamp)
        self.imageName = travelData.imageName
        
        updateGradient(with: travelData.footprint)
        
    }
    
    convenience init(with dataModel: FetchedResults<Travel>.Element) {
        self.init()
        
        self.arrivalTitle = dataModel.arrivalTitle ?? "Error"
        self.arrivalSubtitle = dataModel.arrivalSubtitle ?? "Error"
        self.departureTitle = dataModel.departureTitle ?? "Error"
        self.departureSubtitle = dataModel.departureSubtitle ?? "Error"
        self.distance = numberFormatter.string(from: dataModel.distance as NSNumber) ?? "Error"
        self.transportationType = dataModel.transportationType ?? "Error"
        self.footprint = numberFormatter.string(from: dataModel.footprint as NSNumber) ?? "Error"
        self.timestamp = dateFormatter.string(from: dataModel.timestamp ?? .now)
        self.imageName = dataModel.imageName ?? ""
        
        updateGradient(with: dataModel.footprint)
    }
    
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
    
    var footprintSeverityHigh: [Color] = [.red, .yellow, .green]
    var footprintSeverityMedium: [Color] = [.yellow, .red, .green]
    var footprintSeverityLow: [Color] = [.green, .yellow, .red]
    var arrivalTitle: String
    var arrivalSubtitle: String
    var departureTitle: String
    var departureSubtitle: String
    var distance: String
    var transportationType: String
    var transportationMode: String
    var footprint: String
    var timestamp: String
    var imageName: String
    var footprintSeverityIndicator: [Color] = [.red, .yellow, .green]
    var gradientStartRadius: CGFloat = 0
    var gradientEndRadius: CGFloat = 500
    
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
