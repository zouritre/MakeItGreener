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
                    TravelRow(footprintResult: FootprintResultObservableObject(with: makeTravelData(from: item)))
                        .shadow(color: .white, radius: 5)
                        .padding(3)
                }
            }
        }
        .cornerRadius(20)
        .padding()
        Spacer()
    }
    
    private func makeTravelData(from item: FetchedResults<Travel>.Element) -> TravelData {
        let travelData = TravelData(arrivalTitle: item.arrivalTitle ?? "Error",
                                    arrivalSubtitle: item.arrivalSubtitle ?? "Error",
                                    departureTitle: item.departureTitle ?? "Error",
                                    departureSubtitle: item.departureSubtitle ?? "Error",
                                    distance: item.distance,
                                    transportationType: item.transportationType ?? "Error",
                                    footprint: item.footprint,
                                    timestamp: item.timestamp ?? .init(timeIntervalSince1970: 111111),
                                    imageName: item.imageName ?? "")
        
        return travelData
    }
}

struct TravelListPanel_Previews: PreviewProvider {
    static var previews: some View {
        TravelListPanel()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
