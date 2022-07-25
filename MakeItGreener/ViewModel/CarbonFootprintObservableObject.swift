//
//  CarbonFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class CarbonFootprintObservableObject: NSObject, ObservableObject {
    override init() {
        super.init()
        
        let name = Notification.Name(rawValue: "travel data")
        
        // Get the travel distance as soon as it is set
        NotificationCenter.default.addObserver(
                    self, selector: #selector(listenTravelDistanceChanges(_:)),
                    name: name, object: nil)
    }
    
    /// Travel distance from departure point to arrival
    @Published var formattedTravelDistance = "0 m"
    /// Set to true if the travel carbon footprint has been retrieved successfully from the API
    @Published var hasFootprintResult = false
    /// Set to true if an API request is pending
    @Published var isLoading = false
    /// Co2 footprint value received from API according to the provided travel informations
    @Published var formattedFootprintResult = "0 KgCO2e"
    /// Transportation mode chosen by the user for his travel
    @Published var chosenTransportationMode: TransportationMode = .Vehicule {
        didSet {
            // Set a default value to chosenTransportationType each time it changes
            // to prevent sending an empty value to the API if user don't chose any
            chosenTransportationType = transportationTypes[0]
        }
    }
    /// Transportation type chosen by the user for his travel
    @Published var chosenTransportationType: TransportationType = .SmallPetrolCar
    /// Set to true if an error ocurred when processing the request to API
    @Published var requestError: Bool = false
    /// Description of the error encountered from the API request
    @Published var errorDescription: String?
    
    
    /// Departure location name
    var departure: String?
    /// Arrival location name
    var arrival: String?
    /// Travel distance from departure point to arrival in km
    var travelDistance: Double? {
        didSet {
            let unit = travelDistance ?? 0 >= 1 ? "km" : "m"
            
            // Format any number to max 2 decimals in user local
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            
            guard let travelDistance = travelDistance else {
                formattedTravelDistance = "0 m"
                
                return
            }
            
            // Display the distance value according to the unit
            let distance = unit == "km" ? travelDistance : (travelDistance*1000)
            
            let formattedString = formatter.string(from: distance as NSNumber)
            
            formattedTravelDistance = "\(formattedString ?? "0") \(unit)"
        }
    }
    
    var footprintResult: Double? {
        didSet {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            
            let doubletoString = formatter.string(from: footprintResult as? NSNumber ?? 0) ?? "0"
            formattedFootprintResult = "\(doubletoString) KgCO2e"
        }
    }
    
    /// Every transportation modes avalaible
    var transportationModes = TransportationMode.allCases
    /// Every transportation types avalaible for the chosen transportation mode
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
    
    var travelData: TravelData? {
        willSet {
            if newValue == nil {
                self.requestError.toggle()
                self.errorDescription = "Couldn't retrieve the complete travel data"
            }
            else {
                self.hasFootprintResult = true
            }
        }
    }
    
    /// Store the travl distance whenever it changes
    /// - Parameter notification: The notifcation wich emitted the data
    @objc func listenTravelDistanceChanges(_ notification: Notification) {
        guard let travelDistance = notification.userInfo?["distance"] as? Double else {
            return
        }
        guard let departure = notification.userInfo?["departure"] as? String else {
            return
        }
        guard let arrival = notification.userInfo?["arrival"] as? String else {
            return
        }
        
        self.departure = departure
        self.arrival = arrival
        self.travelDistance = travelDistance/1000
    }
    
    /// Store the travel data in database
    func getCompleteTravelData() -> TravelData? {
        guard let arrival = arrival,
              let departure = departure,
              let travelDistance = travelDistance,
              let footprintResult = footprintResult else { return nil }

        let travelData = TravelData(arrival: arrival, departure: departure, distance: travelDistance, transportationType: chosenTransportationType, transportationMode: chosenTransportationMode, footprint: footprintResult)
        
        return travelData
    }
    
    /// Send the travel form data to the API
    func getFootprint(completionHandler: ((_ endedWithError: Bool, _ errorDescription: String?, _ result: Float?) -> Void)? = nil) {
        guard let travelDistance = travelDistance else {
            requestError = true
            errorDescription = "Couldn't retrieve travel distance"
            return
        }
        
        isLoading = true
        
        // Create an object with the travel form datas
        let travelData = TravelData(distance: travelDistance,
                                    transportationType: chosenTransportationType,
                                    transportationMode: chosenTransportationMode)
        // Contain the API informations
        let api = CarbonFootprintApi()
        // Create an url from the travel form data
        let url = api.co2FootprintUrl(for: travelData)
        // Requiered headers for the request
        let headers = HTTPHeaders(CarbonFootprintConstant.headers)
        
        //Send a request to the API with the provided url and headers
        NetworkService.shared.makeRequest(url: url, method: .get, headers: headers) { data, error in
            guard let data = data, error == nil else {
                if let error = error {
                    // Get the error description
                    self.errorDescription = error.localizedDescription
                    self.requestError = true
                    self.isLoading = false
                    
                    completionHandler?(true, error.errorDescription, nil)
                    
                }
                
                return
            }

            //Decode the JSON response from the server
            guard let json = try? JSON(data: data) else {
                // Get the error description
                self.errorDescription = SwiftyJSONError.invalidJSON.localizedDescription
                self.requestError = true
                self.isLoading = false
                
                completionHandler?(true, SwiftyJSONError.invalidJSON.localizedDescription, nil)
                
                return
            }
        
            self.requestError = false
            
            // Get the carbon footprint of the user according to his travel datas
            self.footprintResult = json["carbonEquivalent"].doubleValue
            
            self.travelData = self.getCompleteTravelData()
            
            self.isLoading = false
            
            completionHandler?(false, nil, json["carbonEquivalent"].floatValue)
                    }
    }
}
