//
//  MyFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct MyFootprintTab: View {
    var body: some View {
        ZStack {
            Image("nature")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Co2TotalPanel()
                Spacer()
                TravelListPanel()
            }
        }
        .statusBar(hidden: true)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        MyFootprintTab()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
