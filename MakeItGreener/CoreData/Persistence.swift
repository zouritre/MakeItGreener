//
//  Persistence.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import CoreData
import MapKit
import Mixpanel

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let aTravel = Travel(context: viewContext)
            
            aTravel.arrivalTitle = "Paris"
            aTravel.arrivalSubtitle = "10ème arrondissement"
            aTravel.departureTitle = "Lyon"
            aTravel.departureSubtitle = "9ème arrondissement"
            aTravel.distance = 500
            aTravel.transportationType = "Small petrol car"
            aTravel.footprint = 123
            aTravel.timestamp = .now
            aTravel.imageName = "car"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

//    let container: NSPersistentCloudKitContainer
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
//        container = NSPersistentCloudKitContainer(name: "MakeItGreener")
        container = NSPersistentContainer(name: "MakeItGreener")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Send the error to analitycs
                Mixpanel.mainInstance().track(event: "Core Data error", properties: [
                    "Description": "\(error.localizedDescription)"])
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
