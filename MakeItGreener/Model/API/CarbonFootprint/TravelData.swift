//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation

///Store data about the user journey
struct TravelData {
    var distance: String
    var type: TypeOfTransport?
    var vehicle: TypeOfVehicule?
    
    ///Dictionnary of every travel data provided by the user
    var datas: [String:String] {
        var dictionnary = [String:String]()
        dictionnary["distance"] = self.distance
        dictionnary["type"] = self.type?.rawValue
        dictionnary["vehicle"] = self.vehicle?.rawValue

        return dictionnary
    }
}
