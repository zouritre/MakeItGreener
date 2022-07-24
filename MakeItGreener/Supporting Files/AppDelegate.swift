//
//  AppDelegate.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 23/07/2022.
//

import Foundation
import SwiftUI
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
