//
//  CarbonFootprintTest.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 17/07/2022.
//

import XCTest
@testable import MakeItGreener
import MapKit

class CarbonFootprintTest: XCTestCase {
    var carbonFootprint: CarbonFootprintObservableObject!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.carbonFootprint = CarbonFootprintObservableObject()
        
        self.carbonFootprint.travelDistance = 500
        
        // Inject a mock request handler in network requests
        NetworkService.shared.configuration.protocolClasses = [MockURLProtocol.self]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransportationTypesCountShouldBeCorrect() {
        // Given
        carbonFootprint.chosenTransportationMode = .Vehicule
        
        // When
        let transportationTypes = carbonFootprint.transportationTypes
        
        // Then
        XCTAssertEqual(transportationTypes.count, 19)
    }
    
    func testGetFootprintShouldReturnError() {
        // Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctCo2FootprintData
        let error: Error? = FakeResponse.error
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        carbonFootprint.getFootprint() { endedWithError,errorDescription,result in
            
            // Then
            XCTAssertTrue(endedWithError)
            XCTAssertNotNil(errorDescription)
            XCTAssertNil(result)
            expectation.fulfill()
        }
        
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetFootprintShouldReturnResponseError() {
        // Given
        let response: HTTPURLResponse? = FakeResponse.responseKO
        let data: Data? = FakeResponse.correctCo2FootprintData
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        carbonFootprint.getFootprint() { endedWithError,errorDescription,result in
            
            // Then
            XCTAssertTrue(endedWithError)
            XCTAssertNotNil(errorDescription)
            XCTAssertNil(result)
            expectation.fulfill()
        }
        
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetFootprintShouldReturnParsingError() {
        // Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        carbonFootprint.getFootprint() { endedWithError,errorDescription,result in
            
            // Then
            XCTAssertTrue(endedWithError)
            XCTAssertNotNil(errorDescription)
            XCTAssertNil(result)
            expectation.fulfill()
        }
        
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetFootprintShouldReturnCorrectDataForVehiculeTypes() {
        // Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctCo2FootprintData
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        carbonFootprint.getFootprint() { endedWithError,errorDescription,result in
            
            // Then
            XCTAssertFalse(endedWithError)
            XCTAssertNil(errorDescription)
            XCTAssertEqual(result, 23.1)
            expectation.fulfill()
        }
        
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetFootprintShouldReturnCorrectDataForOtherTransportTypes() {
        // Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctCo2FootprintData
        let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        self.carbonFootprint.chosenTransportationMode = .Plane
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        carbonFootprint.getFootprint() { endedWithError,errorDescription,result in
            
            // Then
            XCTAssertFalse(endedWithError)
            XCTAssertNil(errorDescription)
            XCTAssertEqual(result, 23.1)
            expectation.fulfill()
        }
        
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testTravelDataObjectShouldBeReturn() {
        // Given
        carbonFootprint.arrival = MKLocalSearchCompletion()
        carbonFootprint.departure = MKLocalSearchCompletion()
        carbonFootprint.travelDistance = Double()
        carbonFootprint.footprintResult = Double()
        
        // When
        let travelData = carbonFootprint.getCompleteTravelData()
        
        // Then
        XCTAssertNotNil(travelData)
    }
}
