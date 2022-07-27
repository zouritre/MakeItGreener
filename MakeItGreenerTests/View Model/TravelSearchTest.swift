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
    
    func testTravelDistanceShouldBeCorrect() {
        // Given
        let location1 = MapLocation(lat: 37.334, long: -122.009, name: .Start)
        let location2 = MapLocation(lat: 37.340, long: -122.001, name: .Arrival)
        
        travelSearch.mapAnnotations.append(location1)
        travelSearch.mapAnnotations.append(location2)
        
        // When
        travelSearch.calculateDistance()
        
        // Then
        XCTAssertEqual(travelSearch.travelDistance, 971.4401132281921)
        
    }
    
    func testTravelDistanceShouldBeUnset() {
        // Given
        let location1 = MapLocation(lat: 37.334, long: -122.009, name: .Start)
        
        travelSearch.mapAnnotations.append(location1)
        
        // When
        travelSearch.calculateDistance()
        
        // Then
        XCTAssertEqual(travelSearch.travelDistance, nil)
        
    }
    
    func testCompletionShouldMatchDepartureLocation() {
        // Given
        travelSearch.travelSide = .Start
        travelSearch.departureLocation = MKLocalSearchCompletion()
        
        // When
        let completion = travelSearch.setLocationFromCompletion(usingCompletion: true)
        
        // Then
        XCTAssertNotNil(completion)
    }
    
    func testCompletionShouldMatchArrivalLocation() {
        // Given
        travelSearch.travelSide = .Arrival
        travelSearch.arrivalLocation = MKLocalSearchCompletion()
        
        // When
        let completion = travelSearch.setLocationFromCompletion(usingCompletion: true)
        
        // Then
        XCTAssertNotNil(completion)
    }
    
    func testCompletionShouldMatchFirstElementOfCompletionArray() {
        // Given
        travelSearch.completerResults.append(MKLocalSearchCompletion())
        
        // When
        let completion = travelSearch.setLocationFromCompletion(usingCompletion: false)
        
        // Then
        XCTAssertNotNil(completion)
    }
    
    func testCompletionShouldBeEmpty() {
        // Given
        travelSearch.completerResults.removeAll()
        
        // When
        let completion = travelSearch.setLocationFromCompletion(usingCompletion: false)
        
        // Then
        XCTAssertNil(completion)
    }
    
    // Test MKLocalSearchCompleterDelegate against the real API response, cannot be simulated
    func testCompleterShouldReturnValues() {
        // Given
        travelSearch.searchTerm = "Paris"
        
        // When
        let expectation = XCTestExpectation(description: "Wait for results")
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            // Then
            XCTAssertGreaterThan(self.travelSearch.completerResults.count, 0)
            
            expectation.fulfill()
            
            timer.invalidate()
        }
        // Then
        //wait 1s for MapKit search API to return
        wait(for: [expectation], timeout: 1)
    }
    
    // Test MKLocalSearchCompleterDelegate against the real API response, cannot be simulated
    func testCompleterShouldHaveError() {
        // Given
        // Random value to prevent the test from using the default value, in wich case will not enter the timer closure
        travelSearch.searchTerm = "o"
        // Set back the desired value
        travelSearch.searchTerm = ""
        
        // When
        let expectation = XCTestExpectation(description: "Wait for results")
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            // Then
            XCTAssertTrue(self.travelSearch.completerHasError)
            
            expectation.fulfill()
            
            timer.invalidate()
        }
        //wait 1s for MapKit search API to return
        wait(for: [expectation], timeout: 1)
    }
    
    // Test Search method against the real MKLocalSearch API response, cannot simulate because it would
    // be necessary to instantiate MKLocalSearchCompletion with arbitrary values, wich is not possible
    func testMapKitSearchApiShouldRespond() {
        // Given
        travelSearch.searchTerm = "Paris"
        travelSearch.departureLocation = MKLocalSearchCompletion()
        travelSearch.arrivalLocation = MKLocalSearchCompletion()
        travelSearch.travelDistance = 492000
        
        // When
        let expectation = XCTestExpectation(description: "Wait for API response")
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            // Wait 1 second after entering the search term for MKLocalSearchCompleterDelegate to respond, then
            self.travelSearch.search(usingCompletion: false)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                // Wait 1 second for MKLocalSearch to execute its closure
                // Then
                XCTAssertGreaterThan(self.travelSearch.mapAnnotations.count, 0)
                
                expectation.fulfill()
            }
        }
        // Then
        //wait 3s for MapKit search API to return
        wait(for: [expectation], timeout: 3)
    }
    
    func testSearchShouldReturnPrematurly() {
        // Given
        travelSearch.completerResults.removeAll()
        
        // When
        travelSearch.search(usingCompletion: false)
        
        // Then
        XCTAssertEqual(travelSearch.mapAnnotations.count, 0)
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
