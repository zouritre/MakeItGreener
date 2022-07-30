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
            MyTravelTabHome()
                .tabItem {
                    Label("My travel", systemImage: "square.and.pencil")
                }
            MyFootprintTab()
                .tabItem {
                    Label("My footprint", systemImage: "leaf")
                }
        }
        .onAppear {
            // MARK: - Tab bar Appearance
            
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = .clear
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .accentColor(.red)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CarbonFootprintObservableObject())
            .environmentObject(travelSearchObservableObject())
    }
}
