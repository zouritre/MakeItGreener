//
//  TransportationMode.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import Foundation
import SwiftUI

enum TransportationMode: String, CaseIterable {
    case Plane = "f"
    case Vehicule = "v"
    case Motorbike = "m"
    case Public = "p"
    
    func description() -> String {
        switch self {
        case .Plane:
            return "Class"
        case .Vehicule:
            return "Type"
        case .Motorbike:
            return "Type"
        case .Public:
            return "Type"
        }
    }
    
    func userString() -> String {
        switch self {
        case .Plane:
            return "Plane"
        case .Vehicule:
            return "Vehicle"
        case .Motorbike:
            return "Motorbike"
        case .Public:
            return "Public transport"
        }
    }
    
    func endpoint() -> CarbonFootprintEndpoint {
        switch self {
        case .Plane:
            return .CarbonFootprintFromFlight
        case .Vehicule:
            return .CarbonFootprintFromCarTravel
        case .Motorbike:
            return .CarbonFootprintFromMotorBike
        case .Public:
            return .CarbonFootprintFromPublicTransit
        }
    }
    
    func imageName() -> String {
        switch self {
            case .Plane:
                return "plane"
            case .Vehicule:
                return "car"
            case .Motorbike:
                return "motorbike"
            case .Public:
                return "train"
        }
    }
}
