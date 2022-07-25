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
//    let persistenceController = PersistenceController.shared
    @StateObject var carbonFootprintOO = CarbonFootprintObservableObject()
    @StateObject var travelSearchOO = travelSearchObservableObject()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(carbonFootprintOO)
                .environmentObject(travelSearchOO)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
