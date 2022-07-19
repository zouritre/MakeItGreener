//
//  travelSearchTest.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 17/07/2022.
//

import XCTest
@testable import MakeItGreener
import MapKit

class travelSearchTest: XCTestCase {
    // Prevent requiering initializer
    var travelSearch: travelSearchObservableObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Reset the instance
        travelSearch = travelSearchObservableObject()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTravelSideShouldAutomaticallySwitchToArrival() {
        // Given
        self.travelSearch.travelSide = .Start
        self.travelSearch.chosenLocations[.Start] = MKCoordinateRegion()
        
        // When
        self.travelSearch.switchToolbarItemFocus()
        
        // Then
        XCTAssertEqual(self.travelSearch.travelSide, .Arrival)
    }
    
    func testTravelSideShouldAutomaticallySwitchToDeparture() {
        // Given
        self.travelSearch.travelSide = .Arrival
        self.travelSearch.chosenLocations[.Arrival] = MKCoordinateRegion()
        
        // When
        self.travelSearch.switchToolbarItemFocus()
        
        // Then
        XCTAssertEqual(self.travelSearch.travelSide, .Start)
    }
    
    func testOldMapAnnotationForSameTravelSideShouldBeRemoved() {
        // Given
        self.travelSearch.travelSide = .Start
        
        let oldAnnotation = MapLocation(lat: 0, long: 0, name: .Start)
        
        self.travelSearch.mapAnnotations.append(oldAnnotation)
        
        // When
        self.travelSearch.addAnnotation(at: .init(latitude: 1, longitude: 0))
        
        // Then
        XCTAssertEqual(self.travelSearch.mapAnnotations[0].location.latitude, 1)
    }
    
    func testMapRegionShouldReturnChosenLocationRegion() {
        // Given
        self.travelSearch.chosenLocations[.Start] = MKCoordinateRegion(
            center:  CLLocationCoordinate2D(
              latitude: 1,
              longitude: 0
            ),
            span: MKCoordinateSpan(
              latitudeDelta: 0.5,
              longitudeDelta: 0.5))
        
        // When
        self.travelSearch.travelSide = .Start
        
        // Then
        XCTAssertEqual(self.travelSearch.region.center.latitude, 1)
    }
    
    func testCompleterShouldHaveSameValueAsSearchTerms() {
        // Given
        self.travelSearch.searchTerm = "test"
        
        // Then
        XCTAssertEqual(self.travelSearch.completer.queryFragment, "test")
    }
    
    
    // Can't test MapKit MKLocalSearch API responses (neither text completion request or location search)
//    func testCompleterShouldHaveResults() {
//        // Given
//        self.travelSearch.searchTerm = "Paris"
//
//        // Then
//        XCTAssertGreaterThan(self.travelSearch.completerResults.count, 1)
//        XCTAssertFalse(self.travelSearch.completerHasError)
//    }
}
