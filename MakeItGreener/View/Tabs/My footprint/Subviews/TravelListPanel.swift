//
//  TravelListPanel.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 01/08/2022.
//

import SwiftUI

struct TravelListPanel: View {
    @FetchRequest(
        sortDescriptors: [])
    private var items: FetchedResults<Travel>
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    makeTravelData(from: item)
                        .shadow(color: .white, radius: 5)
                        .padding(3)
                }
            }
        }
        .cornerRadius(20)
        .padding()
        Spacer()
    }
    
    private func makeTravelData(from item: FetchedResults<Travel>.Element) -> TravelRow? {
        
        guard let arrivalTitle = item.arrivalTitle,
              let arrivalSubtitle = item.arrivalSubtitle,
              let departureTitle = item.departureTitle,
              let departureSubtitle = item.departureSubtitle,
              let transportationType = item.transportationType,
              let timestamp = item.timestamp,
              let imageName = item.imageName else {
            return nil
        }
        
        let travelData = TravelData(arrivalTitle: arrivalTitle, arrivalSubtitle: arrivalSubtitle, departureTitle: departureTitle, departureSubtitle: departureSubtitle, distance: item.distance, transportationType: transportationType, footprint: item.footprint, timestamp: timestamp, imageName: imageName)
        
        return TravelRow(footprintResult: .init(with: travelData))
    }
}

struct TravelListPanel_Previews: PreviewProvider {
    static var previews: some View {
        TravelListPanel()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
