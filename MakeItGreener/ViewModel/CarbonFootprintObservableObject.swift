//
//  CarbonFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class CarbonFootprintObservableObject: ObservableObject {
    @Published var footprintResult = Float()
    @Published var errorFound: Bool = false
    @Published var chosenTransportationMode: TransportationMode = .Vehicule
    @Published var chosenTransportationType: TransportationType = .MediumDieselCar
    
    var errorDescription: String = ""
    var travelDistance: Double = 100
    var transportationModes = TransportationMode.allCases
    var transportationTypes: [TransportationType] {
        let filteredList = TransportationType.allCases.filter {
            guard let transportationId = $0.rawValue.first else {
                return false
            }
            
            return String(transportationId) == self.chosenTransportationMode.rawValue
        }
        
        return filteredList
    }
    
    func getFootprint() {
        print("here")
        let travelData = TravelData(distance: self.travelDistance,
                                    transportationType: self.chosenTransportationType,
                                    transportationMode: self.chosenTransportationMode)
        let api = CarbonFootprintApi()
        let url = api.co2FootprintUrl(for: travelData)
        let headers = HTTPHeaders(CarbonFootprintConstant.headers)
        
        NetworkService.shared.makeRequest(url: url, method: .get, headers: headers) { data, error in
            guard let data = data, error == nil else {
                if let error = error {
                    self.errorDescription = error.localizedDescription
                    self.errorFound = true
                }
                
                return
            }

            guard let json = try? JSON(data: data) else {
                self.errorDescription = SwiftyJSONError.invalidJSON.localizedDescription
                self.errorFound = true
                
                return
            }
        
            self.footprintResult = json["carbonEquivalent"].floatValue
            print(self.footprintResult)
        }
    }
}
