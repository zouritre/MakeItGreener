//
//  TravelData.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation
import MapKit

///Store data about the user journey
public class TravelData: NSObject, NSCoding {

    var arrival: MKLocalSearchCompletion?
    var departure: MKLocalSearchCompletion?
    var distance: Double
    var transportationType: TransportationType
    var transportationMode: TransportationMode
    var footprint: Double?
    var timestamp: Date?
    
    init(arrival: MKLocalSearchCompletion? = nil, departure: MKLocalSearchCompletion? = nil, distance: Double, transportationType: TransportationType, transportationMode: TransportationMode, footprint: Double? = nil, timestamp: Date? = nil) {
        self.arrival = arrival
        self.departure = departure
        self.distance = distance
        self.transportationType = transportationType
        self.transportationMode = transportationMode
        self.footprint = footprint
        self.timestamp = timestamp
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.arrival = aDecoder.decodeObject(forKey: "arrival") as? MKLocalSearchCompletion
        self.departure = aDecoder.decodeObject(forKey: "departure") as? MKLocalSearchCompletion
        self.distance = aDecoder.decodeObject(forKey: "distance") as? Double ?? 0
        self.transportationType = aDecoder.decodeObject(forKey: "transportationType") as? TransportationType ?? .MediumDieselCar
        self.transportationMode = aDecoder.decodeObject(forKey: "transportationMode") as? TransportationMode ?? .Vehicule
        self.footprint = aDecoder.decodeObject(forKey: "footprint") as? Double ?? 0
        self.timestamp = aDecoder.decodeObject(forKey: "timestamp") as? Date ?? Date.now
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(arrival, forKey: "arrival")
        aCoder.encode(departure, forKey: "departure")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(transportationType, forKey: "transportationType")
        aCoder.encode(transportationMode, forKey: "transportationMode")
        aCoder.encode(footprint, forKey: "footprint")
        aCoder.encode(timestamp, forKey: "timestamp")
    }
}
