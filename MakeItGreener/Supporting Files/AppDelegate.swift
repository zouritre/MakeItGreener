//
//  AppDelegate.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 24/07/2022.
//

import Foundation
import Mixpanel

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Initializing a default opt-out state of true
        // will prevent data from being collected by default
        Mixpanel.initialize(token: "ca1e25e8be53aa40c06ca3b983479944", optOutTrackingByDefault: false)
            .serverURL = "https://api-eu.mixpanel.com"
        
        // Send the travel locations for analitycs
        Mixpanel.mainInstance().track(event: "App started")
        
        return true
    }
}
