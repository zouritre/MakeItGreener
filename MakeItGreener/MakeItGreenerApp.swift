//
//  MakeItGreenerApp.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import SwiftUI

@main
struct MakeItGreenerApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var carbonFootprint = CarbonFootprint()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(carbonFootprint)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
