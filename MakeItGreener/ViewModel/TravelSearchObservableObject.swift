//
//  TravelFormObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 14/07/2022.
//

import Foundation
import MapKit

class TravelSearchObservableObject: NSObject, ObservableObject {
    override init() {
        super.init()
        
        completer.delegate = self
    }
    
    
    /// Search completion results
    @Published var completerResults = [MKLocalSearchCompletion]()
    /// Search completion is empty
    @Published var completerHasError = true
    ///Travel point location being edited by the user
    @Published var travelSide: LocationLabel = .Start {
        willSet {
            //Center the map around the departure or arrival location if already chosen
            if let chosenLocation = self.chosenLocations[newValue] {
                self.region = chosenLocation
            }
        }
    }
    /// Locations of the map to place containing an annotation
    @Published var mapAnnotations = [MapLocation]()
    /// Location of the map around wich it is centered, default at Apple Park
    @Published var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
          latitude: 37.334_900,
          longitude: -122.009_020
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.5,
          longitudeDelta: 0.5))
    /// The search bar text
    @Published var searchTerm = "" {
        willSet {
            // Send the partial search text to the completer
            self.completer.queryFragment = newValue
        }
    }
    @Published var departureLocation: MKLocalSearchCompletion?
    @Published var arrivalLocation: MKLocalSearchCompletion?

    var travelDistance: Double?
    /// Provide text completion for the search bar
    var completer = MKLocalSearchCompleter()
    /// Departure and arrival locations chosen by the user
    var chosenLocations = [LocationLabel:MKCoordinateRegion]()
    
    /// Get the coordinates of the location chosen  from the search completion
    func search(usingCompletion: Bool) {
        let completion = setLocationFromCompletion(usingCompletion: usingCompletion)
        
        guard let completion = completion else {
            return
        }

        // Create a search request from the completion object
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        // Set the prefered search region to the map view's region.
        searchRequest.region = self.region
        
        // Send a request against the provided selected completion object
        search.start { [weak self] (response, error) in
            guard let self = self else { return }
            guard let response = response else { return }
            // The coordinates of the selected completion object
            guard let coordinates = response.mapItems[0].placemark.location?.coordinate else { return }

            //Place an annotation at the location of the selected completion object
            self.addAnnotation(at: coordinates)
            
            // Center the map around the selected completion object location
            self.region = MKCoordinateRegion(center: coordinates,
                                             span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            // Store the location of the current departure/arrival point
            self.chosenLocations[self.travelSide] = self.region
            
            self.switchToolbarItemFocus()
            
            self.calculateDistance()
            
            guard let departureLocation = self.departureLocation,
                  let arrivalLocation = self.arrivalLocation,
                  let travelDistance = self.travelDistance  else {
                return
            }
            
            self.sendTravelData(distance: travelDistance, departure: departureLocation, arrival: arrivalLocation)
        }
    }
    
    /// Tell the navigation view to focus the next toolbar item if its associated datas are not yet set
    func switchToolbarItemFocus() {
        if self.chosenLocations.count < 2 {
            self.travelSide = (self.travelSide == .Start) ? .Arrival : .Start
        }
    }
    
    /// Set the completion to use for the map location search
    /// - Parameter usingCompletion: Define if the user  chosen completion will be use or the default one
    /// - Returns: The completion to use for the search
    func setLocationFromCompletion(usingCompletion: Bool) -> MKLocalSearchCompletion? {
        var completion: MKLocalSearchCompletion?
        
        if usingCompletion {
            completion = (self.travelSide == .Start ? self.departureLocation : self.arrivalLocation)
        }
        else {
            completion = completerResults.count > 0 ? completerResults[0] : nil
        }
        
        // Send the searched location to their subscribers according to the travel side
        switch self.travelSide {
        case .Start:
            self.departureLocation = completion
        case .Arrival:
            self.arrivalLocation = completion
        }
        
        return completion
    }
    
    /// Place an annotation at the specified coordinates of the map
    /// - Parameter coordinates: Coordinates  wich will receive an annotation
    func addAnnotation(at coordinates: CLLocationCoordinate2D) {
        // Store the travel location for departure/arrival in an object to be reused
        let newAnnotation = MapLocation(lat: coordinates.latitude, long: coordinates.longitude, name: self.travelSide)

        // Get the location of the previous departure/arrival if any
        let oldAnnotation = self.mapAnnotations.firstIndex {
            $0.name == self.travelSide
        }

        //Remove the previously store location for departure/arrival to prevent duplicates
        if let oldAnnotation = oldAnnotation {
            self.mapAnnotations.remove(at: oldAnnotation)
        }

        //Append the new annotation location object for  departure/arrival
        self.mapAnnotations.append(newAnnotation)
    }
    
    /// Calculate the distance between the departure and arrival locations
    func calculateDistance() {
        // Continue only if both departure and arrival locations are set
        guard mapAnnotations.count == 2 else { return }
        
        let location1 = MKMapPoint.init(mapAnnotations[0].location)
        let location2 = MKMapPoint.init(mapAnnotations[1].location)
        let distance = location1.distance(to: location2)
        
        travelDistance = distance
    }
    
    
    /// Use notification to send the travel datas
    func sendTravelData(distance: Double, departure: MKLocalSearchCompletion, arrival: MKLocalSearchCompletion) {
        // Send the travel distance via notification to CarbonFootprintObservableObject
        let name = Notification.Name(rawValue: "travel data")
        let notification = Notification(name: name, userInfo: [
            "distance":distance,
            "departure":departure,
            "arrival":arrival])
        
        NotificationCenter.default.post(notification)
    }
}

extension TravelSearchObservableObject: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        self.completerHasError = false
        // Store the new results
        completerResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle any errors returned from MKLocalSearchCompleter.
        self.completerHasError = true
    }
}
