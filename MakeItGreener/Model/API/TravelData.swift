//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation

///Store data about the user journey
struct TravelData {
    
    var key = KlimaatApiConstant.key
    
    var start: String
    
    var end: String
    
    var transport_mode: TransportMode
    
    var vehicle_make: String?
    
    var vehicle_model: String?
    
    var vehicle_year: String?
    
    var vehicle_submodel: String?
    
    var vehicle_fuel_type: String?
    
    var vehicle_transmission_type: String?
    
    var vehicle_engine_size: String?
    
    var num_passengers: String?
    
    ///Dictionnary of every travel data provided by the user
    var datas: [String:String] {
        
        var dictionnary = [String:String]()
        
        dictionnary["key"] = self.key.rawValue
        dictionnary["start"] = self.start
        dictionnary["end"] = self.end
        dictionnary["transport_mode"] = self.transport_mode.rawValue
        dictionnary["vehicle_make"] = self.vehicle_make
        dictionnary["vehicle_model"] = self.vehicle_model
        dictionnary["vehicle_year"] = self.vehicle_year
        dictionnary["vehicle_submodel"] = self.vehicle_submodel
        dictionnary["vehicle_fuel_type"] = self.vehicle_fuel_type
        dictionnary["vehicle_transmission_type"] = self.vehicle_transmission_type
        dictionnary["vehicle_engine_size"] = self.vehicle_engine_size
        dictionnary["knum_passengersey"] = self.num_passengers

        return dictionnary
    }
}
