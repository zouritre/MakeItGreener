//
//  FootprintResultTest.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import XCTest
@testable import MakeItGreener
import SwiftUI

class FootprintResultTest: XCTestCase {
    var footprintResult: FootprintResultObservableObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveTravelShouldSucceedWithTravelDataObjectAsInit() {
        // Given
        let travelData = TravelData(arrivalTitle: "a",
                              arrivalSubtitle: "a",
                              departureTitle: "a",
                              departureSubtitle: "a",
                              distance: 0,
                              transportationType: "a",
                              footprint: 0,
                              timestamp: .now,
                              imageName: "a")
        
        // When
        footprintResult = FootprintResultObservableObject(with: travelData)
        
        let viewContext = PersistenceController(inMemory: true).container.viewContext
        
        footprintResult.saveTravel(in: viewContext)
        
        // Then
        XCTAssertFalse(footprintResult.viewContextHasError)
    }
    
//    Can't simulate a FetchedResults<Travel>.Element instance
//    func testSaveTravelShouldSucceedWithFetchResultObjectAsInit() {
//        // Given
//        let dataModelElement = FetchedResults<Travel>.Element()
//
//        // When
//        footprintResult = FootprintResultObservableObject(with: dataModelElement)
//
//        let viewContext = PersistenceController(inMemory: true).container.viewContext
//
//        footprintResult.saveTravel(in: viewContext)
//
//        // Then
//        XCTAssertFalse(footprintResult.viewContextHasError)
//    }
    
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
}
