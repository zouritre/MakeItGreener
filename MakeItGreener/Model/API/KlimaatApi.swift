//
//  KlimaatApi.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation

class KlimaatApi {
    
    /// Base URL of the API
    var baseURL: URL? {
        var component = URLComponents()
        
        component.scheme = "https"
        component.host = "klimaat.app"
        component.path = "/api/v1/calculate"
        
        return component.url
    }
    
    /// Construct an URL with the user travel datas
    /// - Parameter travelData: Details about the user travel
    /// - Returns: A ready to send URL with the user travel datas
    func co2FootprintUrl(for travelData: TravelData) -> URL? {
        var component = URLComponents()
        
        //URL parameters
        var queryItems: [URLQueryItem] = []
        
        for (key, val) in travelData.datas {
            
            let newItem = URLQueryItem(name: key, value: val)
            
            queryItems.append(newItem)
        }
        
        component.queryItems = queryItems
        print(component.url(relativeTo: baseURL)?.absoluteURL)
        return component.url(relativeTo: baseURL)?.absoluteURL
        
    }
    
}
