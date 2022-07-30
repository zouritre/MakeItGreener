//
//  Travel+CoreDataProperties.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 30/07/2022.
//
//

import Foundation
import CoreData


extension Travel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Travel> {
        return NSFetchRequest<Travel>(entityName: "Travel")
    }

    @NSManaged public var data: TravelData?

}

extension Travel : Identifiable {

}
