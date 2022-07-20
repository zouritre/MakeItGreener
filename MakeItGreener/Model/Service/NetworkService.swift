//
//  NetworkService.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 10/07/2022.
//

import Foundation
import Alamofire

final class NetworkService {
    
    /// Singleton
    static let shared = NetworkService()
    
    let configuration: URLSessionConfiguration
    
    var sessionManager: Session
    
    private init() {
        self.configuration = .af.default
        
        self.sessionManager = Session()
    }
    
    func makeRequest(url: URL?, method: HTTPMethod, headers: HTTPHeaders?, completionHandler: @escaping (Data?, AFError?) -> Void) {
        
        //Cancel pending requests
        sessionManager.cancelAllRequests()
        
        //Create a new session
        sessionManager = Alamofire.Session(configuration: configuration)
        
        guard let url = url else {
            return completionHandler(nil, .invalidURL(url: "bad url"))
        }
        
        // Emit a request to specified URL
        sessionManager.request(url, method: method, headers: headers).validate().response { response in
            
            switch response.result {
                
            case .success(let data):
                completionHandler(data, nil)
                
            case .failure(let error):
                completionHandler(nil, error)
                
            }
        }
    }
}

