//
//  FootprintResultObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import Foundation
import SwiftUI
import CoreData
import Mixpanel

class FootprintResultObservableObject: ObservableObject {
    
    init() {
        // Used only for previewing
        self.arrivalTitle = "Paris"
        self.arrivalSubtitle = "10ème arrondissement"
        self.departureTitle = "Lyon"
        self.departureSubtitle = "9ème arrondissement"
        self.distance = "400"
        self.transportationType = "Small petrol car"
        self.footprint = "123"
        self.timestamp = "20/07/2022"
        self.imageName = "car"
    }
    
    convenience init(with travelData: TravelData) {
        self.init()
        
        self.travelData = travelData
        self.arrivalTitle = travelData.arrivalTitle
        self.arrivalSubtitle = travelData.arrivalSubtitle
        self.departureTitle = travelData.departureTitle
        self.departureSubtitle = travelData.departureSubtitle
        self.distance = numberFormatter.string(from: travelData.distance as NSNumber) ?? "Error"
        self.transportationType = travelData.transportationType
        self.footprint = numberFormatter.string(from: travelData.footprint as NSNumber) ?? "Error"
        self.timestamp = dateFormatter.string(from: travelData.timestamp)
        self.imageName = travelData.imageName
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
    
    @Published var viewContextHasError = false
    @Published var saveButtonIcon = "square.and.arrow.down.fill"
    @Published var saveButtonIsEnable = true
    
    var errorDescription = ""
    var travelData: TravelData?
    var arrivalTitle: String
    var arrivalSubtitle: String
    var departureTitle: String
    var departureSubtitle: String
    var distance: String
    var transportationType: String
    var footprint: String
    var timestamp: String
    var imageName: String
    
    func saveTravel(in viewContext: NSManagedObjectContext) {
        let newTravel = Travel(context: viewContext)
        
        guard let travelData = travelData else { return }
        
        newTravel.arrivalTitle = travelData.arrivalTitle
        newTravel.arrivalSubtitle = travelData.arrivalSubtitle
        newTravel.departureTitle = travelData.departureTitle
        newTravel.departureSubtitle = travelData.departureSubtitle
        newTravel.distance = travelData.distance
        newTravel.transportationType = travelData.transportationType
        newTravel.footprint = travelData.footprint
        newTravel.timestamp = travelData.timestamp
        newTravel.imageName = travelData.imageName
        
        do {
            try viewContext.save()
            
            saveButtonIcon = "checkmark.circle.fill"
            
            // Prevent saving the same item multiple times
            saveButtonIsEnable = false
        } catch {
            manageCoreDataError(for: newTravel, with: error)
        }
    }
    
    func manageCoreDataError(for entity: Travel, with error: Error) {
        errorDescription = error.localizedDescription
        
        // Display an alert on the subcriber view
        viewContextHasError.toggle()
        
        saveButtonIcon = "xmark.octagon.fill"
        
        // Send the travel locations for analitycs
        Mixpanel.mainInstance().track(event: "Core data error", properties: [
            "arrivalTitle": "\(entity.arrivalTitle ?? "Error")",
            "arrivalSubtitle": "\(entity.arrivalSubtitle ?? "Error")",
            "departureTitle": "\(entity.departureTitle ?? "Error")",
            "departureSubtitle": "\(entity.departureSubtitle ?? "Error")",
            "distance": "\(entity.distance)",
            "transportationType": "\(entity.transportationType ?? "Error")",
            "footprint": "\(entity.footprint)",
            "timestamp": "\(entity.timestamp ?? .init(timeIntervalSince1970: 0))",
            "imageName": "\(entity.imageName ?? "Error")",
        ])
    }
    
    func removeTravel(with context: NSManagedObjectContext, travel: NSManagedObject) {
        context.delete(travel)
    }
}
