//
//  TravelFormObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 14/07/2022.
//

import Foundation
import MapKit

class travelSearchObservableObject: NSObject, ObservableObject {
    /// Travel distance from departure point to arrival
    @Published var travelDistance: Double = 0
    /// Search completion results
    @Published var completerResults = [MKLocalSearchCompletion]()
    /// Search completion is empty
    @Published var completerIsEmpty = true
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
    /// Result chosen from the search completion
    @Published var selectedCompletion = MKLocalSearchCompletion()
    /// Location of the map around wich it is centered
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
            self.completer.queryFragment = newValue
        }
    }
    
    /// Departure and arrival locations chosen by the user
    private var chosenLocations = [LocationLabel:MKCoordinateRegion]()
    /// Provide text completion for the search bar
    private var completer = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        
        completer.delegate = self
    }
    
    /// Get the coordinates of the location chosen  from the search completion
    func search() {
        // Create a search request from the completion object
        let searchRequest = MKLocalSearch.Request(completion: self.completerResults[0])
        let search = MKLocalSearch(request: searchRequest)
        
        // Set the prefered search region to the map view's region.
        searchRequest.region = self.region
        
        // Send a request against the provided selected completion object
        search.start { [self] (response, error) in
            guard let response = response else {
                return
            }
        
            // The coordinates of the selected completion object
            guard let coordinates = response.mapItems[0].placemark.location?.coordinate else {
                return
            }

            //Place an annotation at the location of the selected completion object
            self.addAnnotation(at: coordinates)
            
            // Center the map around the selected completion object location
            self.region = MKCoordinateRegion(center: coordinates,
                                             span: MKCoordinateSpan(
                                                latitudeDelta: 0.5,
                                                longitudeDelta: 0.5))
            // Store the location of the current departure/arrival point
            self.chosenLocations[self.travelSide] = self.region
        }
    }
    
    /// Place an annotation at the specified coordinates of the map
    /// - Parameter coordinates: Coordinates  wich will receive an annotation
    private func addAnnotation(at coordinates: CLLocationCoordinate2D) {
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
}

extension travelSearchObservableObject: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        self.completerIsEmpty = false
        // Store the new results
        completerResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle any errors returned from MKLocalSearchCompleter.
        self.completerIsEmpty = true
    }
}
