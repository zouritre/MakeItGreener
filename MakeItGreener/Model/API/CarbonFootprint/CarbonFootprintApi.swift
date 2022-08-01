//
//  CarbonFootprintApi.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation

class CarbonFootprintApi {
    
    /// Base URL of the API
    var baseURL: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "carbonfootprint1.p.rapidapi.com"
        
        return component.url
    }
    
    /// Construct an URL with the user travel datas based on the chosen endpoint
    /// - Parameter travelData: Details about the user travel
    /// - Returns: A ready to send URL with the user travel datas
    func co2FootprintUrl(distance: Double, transportationMode: TransportationMode, transportationType: TransportationType) -> URL? {
        var component = URLComponents()
        component.path = transportationMode.endpoint().rawValue
        
        //URL parameters
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: "distance", value: String(distance)))
        
        if transportationMode == .Vehicule {
            queryItems.append(URLQueryItem(name: "vehicle", value: transportationType.apiString()))
        }
        else {
            queryItems.append(URLQueryItem(name: "type", value: transportationType.apiString()))
        }

        component.queryItems = queryItems
        
        return component.url(relativeTo: baseURL)?.absoluteURL
        
    }
    
}
