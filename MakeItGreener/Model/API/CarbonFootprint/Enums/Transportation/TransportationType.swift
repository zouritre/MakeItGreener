//
//  TransportationType.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 13/07/2022.
//

import Foundation

enum TransportationType: String, CaseIterable {
    case Taxi = "p_Taxi"
    case ClassicBus = "p_ClassicBus"
    case EcoBus = "p_EcoBus"
    case Coach = "p_Coach"
    case NationalTrain = "p_NationalTrain"
    case LightRail = "p_LightRail"
    case Subway = "p_Subway"
    case FerryOnFoot = "p_FerryOnFoot"
    case FerryInCar = "p_FerryInCar"
    case DomesticFlight = "f_DomesticFlight"
    case ShortEconomyClassFlight = "f_ShortEconomyClassFlight"
    case ShortBusinessClassFlight = "f_ShortBusinessClassFlight"
    case LongEconomyClassFlight = "f_LongEconomyClassFlight"
    case LongPremiumClassFlight = "f_LongPremiumClassFlight"
    case LongBusinessClassFlight = "f_LongBusinessClassFlight"
    case LongFirstClassFlight = "f_LongFirstClassFlight"
    case SmallPetrolCar = "v_SmallPetrolCar"
    case MediumPetrolCar = "v_MediumPetrolCar"
    case LargePetrolCar = "v_LargePetrolCar"
    case SmallDieselCar = "v_SmallDieselCar"
    case MediumDieselCar = "v_MediumDieselCar"
    case LargeDieselCar = "v_LargeDieselCar"
    case MediumHybridCar = "v_MediumHybridCar"
    case LargeHybridCar = "v_LargeHybridCar"
    case MediumLPGCar = "v_MediumLPGCar"
    case LargeLPGCar = "v_LargeLPGCar"
    case MediumCNGCar = "v_MediumCNGCar"
    case LargeCNGCar = "v_LargeCNGCar"
    case SmallPetrolVan = "v_SmallPetrolVan"
    case LargePetrolVan = "v_LargePetrolVan"
    case SmallDielselVan = "v_SmallDielselVan"
    case MediumDielselVan = "v_MediumDielselVan"
    case LargeDielselVan = "v_LargeDielselVan"
    case LPGVan = "v_LPGVan"
    case CNGVan = "v_CNGVan"
    case SmallMotorBike = "m_SmallMotorBike"
    case MediumMotorBike = "m_MediumMotorBike"
    case LargeMotorBike = "m_LargeMotorBike"

    func userString() -> String {
        switch self {
        case .Taxi:
            return "Taxi"
        case .ClassicBus:
            return "Classic bus"
        case .EcoBus:
            return "Eco bus"
        case .Coach:
            return "Coach"
        case .NationalTrain:
            return "National train"
        case .LightRail:
            return "Light rail"
        case .Subway:
            return "Subway"
        case .FerryOnFoot:
            return "Ferry on foot"
        case .FerryInCar:
            return "Ferry in car"
        case .DomesticFlight:
            return "Domestic flight"
        case .ShortEconomyClassFlight:
            return "Short plane - economy"
        case .ShortBusinessClassFlight:
            return "Short plane - Business"
        case .LongEconomyClassFlight:
            return "Long plane - Economy"
        case .LongPremiumClassFlight:
            return "Long plane - Premium"
        case .LongBusinessClassFlight:
            return "Long plane - Business"
        case .LongFirstClassFlight:
            return "Long plane - FirstClass"
        case .SmallPetrolCar:
            return "Small petrol car"
        case .MediumPetrolCar:
            return "Medium petrol car"
        case .LargePetrolCar:
            return "Large petrol car"
        case .SmallDieselCar:
            return "Small diesel car"
        case .MediumDieselCar:
            return "Medium diesel car"
        case .LargeDieselCar:
            return "Large diesel car"
        case .MediumHybridCar:
            return "Medium hybrid car"
        case .LargeHybridCar:
            return "Large hybrid car"
        case .MediumLPGCar:
            return "Medium LPG car"
        case .LargeLPGCar:
            return "Large LPG car"
        case .MediumCNGCar:
            return "Medium CNG car"
        case .LargeCNGCar:
            return "Large CNG car"
        case .SmallPetrolVan:
            return "Small petrol van"
        case .LargePetrolVan:
            return "Large petrol van"
        case .SmallDielselVan:
            return "Small diesel van"
        case .MediumDielselVan:
            return "Medium diesel van"
        case .LargeDielselVan:
            return "Large diesel van"
        case .LPGVan:
            return "LPG van"
        case .CNGVan:
            return "CNG van"
        case .SmallMotorBike:
            return "Small motorbike"
        case .MediumMotorBike:
            return "Medium motorbike"
        case .LargeMotorBike:
            return "Large motorbike"
        }
    }
    
    func apiString() -> String {
        switch self {
        case .Taxi:
            return "Taxi"
        case .ClassicBus:
            return "ClassicBus"
        case .EcoBus:
            return "EcoBus"
        case .Coach:
            return "Coach"
        case .NationalTrain:
            return "NationalTrain"
        case .LightRail:
            return "LightRail"
        case .Subway:
            return "Subway"
        case .FerryOnFoot:
            return "FerryOnFoot"
        case .FerryInCar:
            return "FerryInCar"
        case .DomesticFlight:
            return "DomesticFlight"
        case .ShortEconomyClassFlight:
            return "ShortEconomyClassFlight"
        case .ShortBusinessClassFlight:
            return "ShortBusinessClassFlight"
        case .LongEconomyClassFlight:
            return "LongEconomyClassFlight"
        case .LongPremiumClassFlight:
            return "LongPremiumClassFlight"
        case .LongBusinessClassFlight:
            return "LongBusinessClassFlight"
        case .LongFirstClassFlight:
            return "LongFirstClassFlight"
        case .SmallPetrolCar:
            return "SmallPetrolCar"
        case .MediumPetrolCar:
            return "MediumPetrolCar"
        case .LargePetrolCar:
            return "LargePetrolCar"
        case .SmallDieselCar:
            return "SmallDieselCar"
        case .MediumDieselCar:
            return "MediumDieselCar"
        case .LargeDieselCar:
            return "LargeDieselCar"
        case .MediumHybridCar:
            return "MediumHybridCar"
        case .LargeHybridCar:
            return "LargeHybridCar"
        case .MediumLPGCar:
            return "MediumLPGCar"
        case .LargeLPGCar:
            return "LargeLPGCar"
        case .MediumCNGCar:
            return "MediumCNGCar"
        case .LargeCNGCar:
            return "LargeCNGCar"
        case .SmallPetrolVan:
            return "SmallPetrolVan"
        case .LargePetrolVan:
            return "LargePetrolVan"
        case .SmallDielselVan:
            return "SmallDielselVan"
        case .MediumDielselVan:
            return "MediumDielselVan"
        case .LargeDielselVan:
            return "LargeDielselVan"
        case .LPGVan:
            return "LPGVan"
        case .CNGVan:
            return "CNGVan"
        case .SmallMotorBike:
            return "SmallMotorBike"
        case .MediumMotorBike:
            return "MediumMotorBike"
        case .LargeMotorBike:
            return "LargeMotorBike"
        }
    }
}
