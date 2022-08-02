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
            if #available(iOS 14.0, *) {
                Image("nature")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                // Fallback on earlier versions
                Image("nature")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
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
