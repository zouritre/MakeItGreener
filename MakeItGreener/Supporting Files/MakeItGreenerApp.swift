//
//  MakeItGreenerApp.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import SwiftUI

@main
struct MakeItGreenerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var carbonFootprintOO = CarbonFootprintObservableObject()
    @StateObject var travelSearchOO = TravelSearchObservableObject()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(carbonFootprintOO)
                .environmentObject(travelSearchOO)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
