//
//  FootprintResultTest.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 27/07/2022.
//

import XCTest
@testable import MakeItGreener
import MapKit

class FootprintResultTest: XCTestCase {
    var footprintResult: FootprintResultObservableObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPublishersShouldHaveTravelDataValue() {
        // Given
        let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 50)
        
        // When
        footprintResult = FootprintResultObservableObject(with: travelData)
        
        // Then
        XCTAssertNotNil(footprintResult.arrival)
        XCTAssertNotNil(footprintResult.departure)
        XCTAssertEqual(footprintResult.distance, "492")
        XCTAssertEqual(footprintResult.transportationType, .SmallPetrolCar)
        XCTAssertEqual(footprintResult.transportationMode, .Vehicule)
        XCTAssertEqual(footprintResult.footprint, "50")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
