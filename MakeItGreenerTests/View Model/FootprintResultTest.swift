////
////  FootprintResultTest.swift
////  MakeItGreenerTests
////
////  Created by Bertrand Dalleau on 27/07/2022.
////
//
//import XCTest
//@testable import MakeItGreener
//import MapKit
//
//class FootprintResultTest: XCTestCase {
//    var footprintResult: FootprintResultViewModel!
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 50)
//        
//        footprintResult = FootprintResultViewModel(with: travelData)
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testPublishersShouldHaveTravelDataValue() {
//        // Given
//        let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 50)
//        
//        // When
//        footprintResult = FootprintResultViewModel(with: travelData)
//        
//        // Then
//        XCTAssertNotNil(footprintResult.arrival)
//        XCTAssertNotNil(footprintResult.departure)
//        XCTAssertEqual(footprintResult.distance, "492")
//        XCTAssertEqual(footprintResult.transportationType, .SmallPetrolCar)
//        XCTAssertEqual(footprintResult.transportationMode, .Vehicule)
//        XCTAssertEqual(footprintResult.footprint, "50")
//    }
//
//    func testFootprintSeverityShouldBeLow() {
//        // Given
//        let footprint = 99.2
//        
//        // When
//        footprintResult.updateGradient(with: footprint)
//        
//        // Then
//        XCTAssertEqual(footprintResult.footprintSeverityIndicator, footprintResult.footprintSeverityLow)
//    }
//    
//    func testFootprintSeverityShouldBeMedium() {
//        // Given
//        let footprint = 299.2
//        
//        // When
//        footprintResult.updateGradient(with: footprint)
//        
//        // Then
//        XCTAssertEqual(footprintResult.footprintSeverityIndicator, footprintResult.footprintSeverityMedium)
//    }
//    
//    func testFootprintSeverityShouldBeHigh() {
//        // Given
//        let footprint = 300.2
//        
//        // When
//        footprintResult.updateGradient(with: footprint)
//        
//        // Then
//        XCTAssertEqual(footprintResult.footprintSeverityIndicator, footprintResult.footprintSeverityHigh)
//    }
//}
