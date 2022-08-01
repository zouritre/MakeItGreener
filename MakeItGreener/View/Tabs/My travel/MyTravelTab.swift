//
//  MyTravelTabHome.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct MyTravelTab: View {
    var body: some View {
        NavigationView {
            MapView()
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .statusBar(hidden: true)
        }
    }
}

struct MyTravelTab_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelTab()
            .environmentObject(travelSearchObservableObject())
            .environmentObject(CarbonFootprintObservableObject())
    }
}
