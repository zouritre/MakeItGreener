//
//  CarbonFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class CarbonFootprint: ObservableObject {
    @Published var footprint = Float()
    @Published var footprintAvailable = false
    @Published var errorFound: Bool = false
    
    var errorDescription: String = ""
    
    func getFootprint(for travelData: TravelData) {
        
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
        
            self.footprint = json["carbonEquivalent"].floatValue
            self.footprintAvailable = true
            print(self.footprint)
        }
    }
}
