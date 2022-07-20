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
        
        let name = Notification.Name(rawValue: "travelDistance")
        
        NotificationCenter.default.addObserver(
                    self, selector: #selector(listenTravelDistanceChanges(_:)),
                    name: name, object: nil)
    }
    /// Co2 footprint value received from API according to the provided travel informations
    @Published var footprintResult = Float()
    /// Set to true if an error ocurred when processing the request to API
    @Published var requestError: Bool = false
    /// Transportation mode chosen by the user for his travel
    @Published var chosenTransportationMode: TransportationMode = .Vehicule
    /// Transportation type chosen by the user for his travel
    @Published var chosenTransportationType: TransportationType = .MediumDieselCar
    /// Description of the error encountered from the API request
    @Published var errorDescription: String?
    
    /// Travel distance from departure point to arrival
    var travelDistance: Double = 0
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
    
    /// Store the travl distance whenever it changes
    /// - Parameter notification: The notifcation wich emitted the data
    @objc func listenTravelDistanceChanges(_ notification: Notification) {
        guard let travelDistance = notification.userInfo?["value"] as? Double else {
            return
        }
        
        self.travelDistance = travelDistance/1000
    }
    
    /// Send the travel form data to the API
    func getFootprint(completionHandler: ((_ endedWithError: Bool, _ errorDescription: String?, _ result: Float?) -> Void)? = nil) {
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
                    completionHandler?(true, error.errorDescription, nil)
                }
                
                return
            }

            //Decode the JSON response from the server
            guard let json = try? JSON(data: data) else {
                // Get the error description
                self.errorDescription = SwiftyJSONError.invalidJSON.localizedDescription
                self.requestError = true
                completionHandler?(true, SwiftyJSONError.invalidJSON.localizedDescription, nil)
                
                return
            }
        
            self.requestError = false
            
            // Get the carbon footprint of the user according to his travel datas
            self.footprintResult = json["carbonEquivalent"].floatValue
            
            completionHandler?(false, nil, json["carbonEquivalent"].floatValue)
            print(self.footprintResult)
        }
    }
}
