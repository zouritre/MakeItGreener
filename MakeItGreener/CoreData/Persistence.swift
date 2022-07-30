//
//  Persistence.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import CoreData
import MapKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let data = TravelData(distance: 509, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 3000, timestamp: .now)
            
            let aTravel = Travel(context: viewContext)
            aTravel.data = data
        }
        do {
            try viewContext.save()
        } catch {
            print("Save failed")
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
