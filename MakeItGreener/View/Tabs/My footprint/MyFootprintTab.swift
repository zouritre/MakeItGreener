//
//  MyFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct MyFootprintTab: View {
    var body: some View {
        VStack(alignment: .center) {
            Co2TotalPanel()
            Spacer()
            TravelListPanel()
            Spacer()
        }
        .background(Image("nature")
            .resizable())
        .statusBar(hidden: true)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        MyFootprintTab()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
