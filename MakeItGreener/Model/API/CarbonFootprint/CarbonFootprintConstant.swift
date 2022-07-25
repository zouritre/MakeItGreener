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
    private static let key = "78118ed910msh136e91cee2445d2p1bb385jsne0c4bbfe72fb"
    private static let host = "carbonfootprint1.p.rapidapi.com"
    static let headers: [HTTPHeader] = [HTTPHeader(name: "X-RapidAPI-Key", value: key), HTTPHeader(name: "X-RapidAPI-Host", value: host)]
}
