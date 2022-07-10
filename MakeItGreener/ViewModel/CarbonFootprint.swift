//
//  CarbonFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol CarbonFootprintDelegate {
    func carbonFootprint(value: Float?, error: Error?)
}

class CarbonFootprint {
    
    var carbonFootprintDelegate: CarbonFootprintDelegate?
    
    func getFootprint(for travelData: TravelData, on endpoint: CarbonFootprintEndpoint) {
        
        let api = CarbonFootprintApi()
        
        let url = api.co2FootprintUrl(for: travelData, on: endpoint)
        
        NetworkService.shared.makeRequest(url: url, method: .get) { data, error in
            guard let data = data, error == nil else {
                self.carbonFootprintDelegate?.carbonFootprint(value: nil, error: error)
                return
            }

            guard let json = try? JSON(data: data) else {
                self.carbonFootprintDelegate?.carbonFootprint(value: nil, error: SwiftyJSONError.invalidJSON)
                return
            }
        
            self.carbonFootprintDelegate?.carbonFootprint(value: json["carbonEquivalent"].floatValue, error: nil)
            
        }
    }
}
