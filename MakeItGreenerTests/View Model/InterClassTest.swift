//
//  Inter_class.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 26/07/2022.
//

import XCTest
@testable import MakeItGreener

class InterClassTest: XCTestCase {
    var carbonFootprint: CarbonFootprintObservableObject!
    var travelSearch: travelSearchObservableObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        carbonFootprint = CarbonFootprintObservableObject()
        travelSearch = travelSearchObservableObject()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllTravelDataShouldBeReceivedViaNotification() {
        // Given
        travelSearch.sendTravelData(distance: 492000, departure: "Paris", arrival: "Lyon")
        
        // Then
        XCTAssertEqual(carbonFootprint.departure, "Paris")
        XCTAssertEqual(carbonFootprint.arrival, "Lyon")
        XCTAssertEqual(carbonFootprint.travelDistance, 492)
    }
}
