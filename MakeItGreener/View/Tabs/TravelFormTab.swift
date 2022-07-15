//
//  TravelForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TravelFormTab: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    @State private var locations = [
        MapLocation(lat: 37.334_900, long: -122.009_020, name: .Start),
        MapLocation(lat: 37.334_910, long: -121.9, name: .Arrival)]
    @State private var searchLocation = ""
    @State private var selectedNavItem: LocationLabel = .Start
    
    var navigationTitle: String {
        selectedNavItem == .Start ? "Where do you start ?" : "Where do you go ?"
    }
    
    init() {
//        let bounds = UINavigationBar().bounds
//            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//        visualEffectView.frame = bounds
//            visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        visualEffectView.layer.zPosition = -1
//            UINavigationBar().insertSubview(visualEffectView, at: 0)
//        UINavigationBar().alpha = 1

    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MapView(locations: $locations)
//                    .edgesIgnoringSafeArea([.top])
                Form {
                    Section(content: {
                        DistanceForm(locations: $locations)
                    }, header: {
                        Text("Distance")
                    }, footer: {
                        Text(String("\(carbonFootprintOO.travelDistance) km"))
                    })
                    Section(content: {
                        TransportationModeView()
                        TransportationTypeView()
                    }, header: {
                        Text("Transportation")
                    })
                    Section {
                        NavigationLink( destination: {EmptyView()}) {
                            Button(action: {
//                                carbonFootprintOO.getFootprint()
                                //Disable button
                                //Enable activity indicator
                            }, label: {
                                Label("How green am I", systemImage: "leaf.circle.fill")
                            })
                            .symbolRenderingMode(.multicolor)
                        }
                        
                        .alert(self.carbonFootprintOO.errorDescription, isPresented: $carbonFootprintOO.errorFound, actions: {
                            //Disable activity indicator
                            //Re-enable button
                            return Text("I'll fix that")
                        })
                    }
                }
                .navigationTitle(self.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.selectedNavItem = .Start
                        }, label: {
                            Label("Start", systemImage: "figure.walk")
                        })
                        .foregroundColor(selectedNavItem == .Start ? .red : .blue)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.selectedNavItem = .Arrival
                        }, label: {
                            Label("Destination", systemImage: "flag.fill")
                        })
                        .foregroundColor(selectedNavItem == .Arrival ? .red : .blue)
                    }
                }
            }
        }
        //Always display search bar
        .searchable(text: $searchLocation, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a location")
        .navigationViewStyle(.stack)
        
    }
}

struct TravelFormTab_Previews: PreviewProvider {
    static var previews: some View {
        TravelFormTab()
            .environmentObject(CarbonFootprintObservableObject())
            .environmentObject(travelSearchObservableObject())
    }
}
