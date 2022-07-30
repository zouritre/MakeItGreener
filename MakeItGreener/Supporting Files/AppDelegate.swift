//
//  AppDelegate.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 24/07/2022.
//

import Foundation
import SwiftUI
import Mixpanel
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Initializing a default opt-out state of true
        // will prevent data from being collected by default
        let mixpanel = Mixpanel.initialize(token: "ca1e25e8be53aa40c06ca3b983479944", optOutTrackingByDefault: false)
        mixpanel.serverURL = "https://api-eu.mixpanel.com"
        
        return true
    }
}
