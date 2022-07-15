//
//  TravelFormObservableObject.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 14/07/2022.
//

import Foundation
import MapKit

class travelSearchObservableObject: NSObject, ObservableObject {
    @Published var travelDistance: Double = 0
    @Published var completerResults = [MKLocalSearchCompletion]()
    @Published var travelSide: LocationLabel = .Start
    @Published var mapAnnotations = [MapLocation]()
    @Published var selectedCompletion = MKLocalSearchCompletion()
    @Published var locationIsValid = false {
        willSet {
            if newValue {
                self.search()
            }
        }
    }
    @Published var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
          latitude: 37.334_900,
          longitude: -122.009_020
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.5,
          longitudeDelta: 0.5))
    @Published var searchTerm = "" {
        willSet {
            self.completer.queryFragment = newValue
        }
    }
    
    private var completer = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        
        completer.delegate = self
    }
    
    func search() {
        print("here!!!!!!!!!!")
        
        let searchRequest = MKLocalSearch.Request(completion: self.completerResults[0])
        searchRequest.region = self.region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [self] (response, error) in
            guard let response = response else {
                // Handle the error.
                print("iam here")
                return
            }
        
            guard let coordinates = response.mapItems[0].placemark.location?.coordinate else {
                print("iam there")
                return
            }

            self.addAnnotation(at: coordinates)
            self.region = MKCoordinateRegion(center: coordinates,
                                             span: MKCoordinateSpan(
                                                latitudeDelta: 0.5,
                                                longitudeDelta: 0.5))
        }
    }
    
    private func addAnnotation(at coordinates: CLLocationCoordinate2D) {
        let newAnnotation = MapLocation(lat: coordinates.latitude, long: coordinates.longitude, name: self.travelSide)

        let oldAnnotation = self.mapAnnotations.firstIndex {
            $0.name == self.travelSide
        }

        if let oldAnnotation = oldAnnotation {
            self.mapAnnotations.remove(at: oldAnnotation)
        }

        self.mapAnnotations.append(newAnnotation)
    }
}

extension travelSearchObservableObject: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        // Overwrite the existing results, and then refresh the UI with the new results.
        completerResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle any errors returned from MKLocalSearchCompleter.
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
        }
    }
}
