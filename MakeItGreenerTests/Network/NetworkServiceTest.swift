//
//  NetworkServiceTest.swift
//  MakeItGreenerTests
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import XCTest
@testable import MakeItGreener

class NetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Inject a mock request handler in network requests
        NetworkService.shared.configuration.protocolClasses = [MockURLProtocol.self]
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakeRequestShouldReturnDataIfServerResponseIsValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        NetworkService.shared.makeRequest(url: URL(string: "https://stackoverflow.com"), method: .get, headers: []){ data, error in
            
        // Then
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testMakeRequestShouldReturnErrorIfServerResponseIsNotValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseKO
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        //Random parameters, does not matter
        NetworkService.shared.makeRequest(url: URL(string: "https://stackoverflow.com"), method: .get, headers: []){ data, error in

        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }

    func testMakeRequestShouldReturnFailCallbackIfEror() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = FakeResponse.error

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        //Random parameters, does not matter
        NetworkService.shared.makeRequest(url: URL(string: "https://stackoverflow.com"), method: .get, headers: []){ data, error in

        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testMakeRequestShouldReturnFailIfBadUrl() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        NetworkService.shared.makeRequest(url: URL(string: ""), method: .get, headers: []){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 100ms for closure to return
        wait(for: [expectation], timeout: 0.1)
        
    }
}


