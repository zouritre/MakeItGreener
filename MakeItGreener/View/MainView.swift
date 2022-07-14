//
//  MainView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 09/07/2022.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            TravelFormTab()
                .tabItem {
                    Label("Calculate", systemImage: "square.and.pencil")
                }
            MyFootprintTab()
                .tabItem {
                    Label("My footprint", systemImage: "leaf")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
