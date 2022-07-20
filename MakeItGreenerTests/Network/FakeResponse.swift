//
//  FakeCurrencySymbolResponse.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 27/05/2022.
//

import Foundation

class FakeResponse {
    static let responseOK = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class SomeError: Error {}
    
    static let error = SomeError()
    
    private static let bundle = Bundle(for: FakeResponse.self)
    
    static var correctCo2FootprintData: Data? {
    
        let url = bundle.url(forResource: "Co2FootprintData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static let randomData = "some data".data(using: .utf8)
}
