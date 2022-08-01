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
                    TravelRow(footprintResult: FootprintResultObservableObject(with: item))
                        .shadow(color: .white, radius: 5)
                        .padding(3)
                }
            }
        }
        .cornerRadius(20)
        .padding()
        Spacer()
    }
}

struct TravelListPanel_Previews: PreviewProvider {
    static var previews: some View {
        TravelListPanel()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
