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

    func testSaveTravelShouldSucceed() {
        // Given
        let travelData = TravelData(arrivalTitle: "",
                              arrivalSubtitle: "",
                              departureTitle: "",
                              departureSubtitle: "",
                              distance: 0,
                              transportationType: "",
                              footprint: 0,
                              timestamp: .now,
                              imageName: "")
        
        footprintResult = FootprintResultObservableObject(with: travelData)
        
        let viewContext = PersistenceController(inMemory: true).container.viewContext
        
        // When
        footprintResult.saveTravel(in: viewContext)
        
        // Then
        XCTAssertFalse(footprintResult.viewContextHasError)
    }
}
