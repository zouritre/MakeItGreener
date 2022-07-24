//
//  MyTravelTabHome.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct MyTravelTabHome: View {
    var body: some View {
        NavigationView {
            MapView()
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .statusBar(hidden: true)
        }
    }
}

struct MyTravelTabHome_Previews: PreviewProvider {
    static var previews: some View {
        MyTravelTabHome()
            .environmentObject(travelSearchObservableObject())
    }
}
