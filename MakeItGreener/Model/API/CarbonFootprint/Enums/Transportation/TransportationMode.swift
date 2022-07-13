//
//  TransportationMode.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import Foundation

enum TransportationMode: String, CaseIterable {
    case Plane = "f"
    case Vehicule = "v"
    case Public = "p"
    
    func description() -> String {
        switch self {
        case .Plane:
            return "Travel class"
        case .Vehicule:
            return "Vehicule type"
        case .Public:
            return "Transportation type"
        }
    }
    
    func userString() -> String {
        switch self {
        case .Plane:
            return "Plane"
        case .Vehicule:
            return "Vehicule"
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
        case .Public:
            return .CarbonFootprintFromPublicTransit
        }
    }
//
//    func transportationTypes() -> [String] {
//        switch self {
//        case .Plane:
//            return enumToStringArray(from: VehiculeType.allCases)
//        case .Vehicule:
//            return enumToStringArray(from: VehiculeType.allCases)
//        case .Public:
//            return enumToStringArray(from: VehiculeType.allCases)
//        }
//    }
//
//    func enumToStringArray<T: RawRepresentable>(from array: [T]) -> [T.RawValue] {
//        var stringArray = [T.RawValue]()
//        array.forEach { element in
//            stringArray.append(element.rawValue)
//        }
//        return stringArray
//    }
    
}
