//
//  CarbonFootprintConstant.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation
import Alamofire

/// API sensible datas
class CarbonFootprintConstant {
    
    ///API key
    private static let key = "your_api_key"
    private static let host = "carbonfootprint1.p.rapidapi.com"
    static let headers: [HTTPHeader] = [HTTPHeader(name: "X-RapidAPI-Key", value: key), HTTPHeader(name: "X-RapidAPI-Host", value: host)]
}
