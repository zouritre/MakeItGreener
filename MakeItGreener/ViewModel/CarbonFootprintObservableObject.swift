//
//  CarbonFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import MapKit
import Mixpanel

class CarbonFootprintObservableObject: NSObject, ObservableObject {
    
    /// Set to true if an API request is pending
    var isLoading = false
    /// Description of the error encountered from the API request
    var errorDescription: String?
    /// Departure location name
    var departure: MKLocalSearchCompletion?
    /// Arrival location name
    var arrival: MKLocalSearchCompletion?
    /// Footprint calculated by the API according to the travel configuration
    var footprintResult: Double?
    /// Every transportation modes avalaible
    var transportationModes = TransportationMode.allCases
    
    /// Transportation types avalaible for the chosen transportation mode
    var transportationTypes: [TransportationType] {
        let filteredList = TransportationType.allCases.filter {
            //Get the transportation type prefix on the current element
            guard let transportationId = $0.rawValue.first else {
                return false
            }
            
            //Return the element if it's prefix matches the chosen transportation mode
            return String(transportationId) == self.chosenTransportationMode.rawValue
        }
        
        return filteredList
    }
    
    /// Format a decimal number to a max 2 digit number  in the device locale
    var formatter: NumberFormatter {
        // Format any number to max 2 decimals in user local
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Travel distance from departure point to arrival in km
    var travelDistance: Double = 0 {
        didSet {
            let unit = travelDistance >= 1 ? "km" : "m"
            
            // Display the distance value according to the unit
            let distance = unit == "km" ? travelDistance : (travelDistance*1000)
            
            // Convert the Double to a String
            let formattedString = formatter.string(from: distance as NSNumber)
            
            // Set the property to a human readable format
            formattedTravelDistance = "\(formattedString ?? "0") \(unit)"
        }
    }
    
    /// Travel distance from departure point to arrival
    @Published var formattedTravelDistance = "0 m"
    /// Set to true if the travel carbon footprint has been retrieved successfully from the API
    @Published var hasFootprintResult = false {
        didSet {
            // Send the travel locations for analitycs
            Mixpanel.mainInstance().track(event: "Get my footprint request", properties: [
                "Distance": "\(travelDistance)",
                "Transportation": "\(chosenTransportationType.userString())",
                "Footprint": "\(footprintResult ?? 0)"
                ])
        }
    }
    /// Transportation type chosen by the user for his travel
    @Published var chosenTransportationType: TransportationType = .SmallPetrolCar
    /// Set to true if an error ocurred when processing the request to API
    @Published var requestError: Bool = false
    /// Transportation mode chosen by the user for his travel
    @Published var chosenTransportationMode: TransportationMode = .Vehicule {
        didSet {
            // Set a default value to chosenTransportationType each time it changes
            // to prevent sending an empty value to the API if user don't chose any
            chosenTransportationType = transportationTypes[0]
        }
    }
    
    override init() {
        super.init()
        
        let name = Notification.Name(rawValue: "travel data")
        
        // Set up a listener to get the travel distance as soon as it changes in TravelSearchObservableObject
        NotificationCenter.default.addObserver(
            self, selector: #selector(listenTravelDistanceChanges(_:)),
            name: name, object: nil)
    }
    
    /// Set properties from the received notification
    /// - Parameter notification: The notifcation wich emitted the data
    @objc func listenTravelDistanceChanges(_ notification: Notification) {
        guard let travelDistance = notification.userInfo?["distance"] as? Double,
              let departure = notification.userInfo?["departure"] as? MKLocalSearchCompletion,
              let arrival = notification.userInfo?["arrival"] as? MKLocalSearchCompletion
        else { return }
        
        self.departure = departure
        self.arrival = arrival
        // Convert the distance form meters to kms
        self.travelDistance = travelDistance/1000
    }
    
    /// Store the travel data from the form in an object
    func getCompleteTravelData() -> TravelData {
        guard let arrival = arrival,
              let departure = departure,
              let footprintResult = footprintResult
        else {
            let travelDataError = TravelData(arrivalTitle: "Error",
                                             arrivalSubtitle: "Error",
                                             departureTitle: "Error",
                                             departureSubtitle: "Error",
                                             distance: 0,
                                             transportationType: "Error",
                                             footprint: 0,
                                             timestamp: .now,
                                             imageName: "Error")
            
            return travelDataError
        }
        
        let travelData = TravelData(arrivalTitle: arrival.title,
                                    arrivalSubtitle: arrival.subtitle,
                                    departureTitle: departure.title,
                                    departureSubtitle: departure.subtitle,
                                    distance: travelDistance,
                                    transportationType: chosenTransportationType.userString(),
                                    footprint: footprintResult,
                                    timestamp: .now,
                                    imageName: chosenTransportationMode.imageName())
        
        return travelData
    }
    
    /// Send the travel form data to the API
    func getFootprint(completionHandler: ((_ endedWithError: Bool, _ errorDescription: String?, _ result: Float?) -> Void)? = nil) {
        
        // Start the loading indicator
        isLoading = true
        
        // Contain the API informations
        let api = CarbonFootprintApi()
        // Create an url from the travel form data
        let url = api.co2FootprintUrl(distance: travelDistance,
                                      transportationMode: chosenTransportationMode,
                                      transportationType: chosenTransportationType)
        // Requiered headers for the request
        let headers = HTTPHeaders(CarbonFootprintConstant.headers)
        
        //Send a request to the API with the provided url and headers
        NetworkService.shared.makeRequest(url: url,
                                          method: .get,
                                          headers: headers) { data, error in
            guard let data = data, error == nil else {
                if let error = error {
                    // Get the error description
                    self.errorDescription = error.localizedDescription
                    // Display an alert
                    self.requestError.toggle()
                    // Stop the loading indicator
                    self.isLoading = false
                    
                    completionHandler?(true, error.errorDescription, nil)
                }
                
                return
            }
            
            //Decode the JSON response from the server
            guard let json = try? JSON(data: data) else {
                // Get the error description
                self.errorDescription = SwiftyJSONError.invalidJSON.localizedDescription
                // Display an alert
                self.requestError.toggle()
                // Stop the loading indicator
                self.isLoading = false
                
                completionHandler?(true, SwiftyJSONError.invalidJSON.localizedDescription, nil)
                
                return
            }
            
            // Get the carbon footprint of the user according to his travel datas
            self.footprintResult = json["carbonEquivalent"].doubleValue
            // Stop the loading indicator
            self.isLoading = false
            
            // Start navigation to Co2ResultView
            self.hasFootprintResult = true
            
            completionHandler?(false, nil, json["carbonEquivalent"].floatValue)
        }
    }
}
