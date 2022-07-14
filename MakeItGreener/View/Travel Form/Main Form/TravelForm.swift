//
//  TravelForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TravelForm: View {
    @EnvironmentObject var carbonFootprint: CarbonFootprint
    
    @State private var locations = [
        MapLocation(lat: 37.334_900, long: -122.009_020, name: .Start),
        MapLocation(lat: 37.334_910, long: -121.9, name: .Arrival)]
    @State var chosenTransportationMode: TransportationMode = .Vehicule
    @State var chosenTransportationType: TransportationType = .MediumDieselCar
    @State private var searchLocation = ""
    @State private var selectedNavItem: LocationLabel = .Start

    var distance: Float {
        return 1000
    }
    var navigationTitle: String {
        selectedNavItem == .Start ? "Where do you start ?" : "Where do you go ?"
    }
    
    var body: some View {
        VStack(spacing: 0) {
                MapView(locations: $locations)
                .edgesIgnoringSafeArea([.top])
                NavigationView {
                    Form {
                        Section(content: {
                            DistanceForm(locations: $locations)
                        }, header: {
                            Text("Distance")
                        }, footer: {
                            Text(String("\(distance) km"))
                        })
                        Section(content: {
                            TransportationForm(chosenTransportationMode: $chosenTransportationMode, chosenTransportationType: $chosenTransportationType)
                        }, header: {
                            Text("Transportation")
                        })
                        Section {
                            Button(action: {
                                let travelData = TravelData(distance: self.distance, transportationType: self.chosenTransportationType, transportationMode: self.chosenTransportationMode)
                                
                                carbonFootprint.getFootprint(for: travelData)
                                //Disable button
                                //Enable activity indicator
                            }, label: {
                                Label("How green am I", systemImage: "leaf.circle.fill")
                            })
                            .symbolRenderingMode(.multicolor)
                            .alert(self.carbonFootprint.errorDescription, isPresented: $carbonFootprint.errorFound, actions: {
                                //Disable activity indicator
                                //Re-enable button
                                return Text("I'll fix that")
                            })
                        }
                    }
                    .navigationTitle(navigationTitle)
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
                    NavigationLink(isActive: $carbonFootprint.footprintAvailable, destination: { EmptyView() }, label: { Text("ResultView")})
                }
                //Always display search bar
                .searchable(text: $searchLocation, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a location")
                .navigationViewStyle(.stack)
            }
    }
}

struct TravelForm_Previews: PreviewProvider {
    static var previews: some View {
        TravelForm(chosenTransportationMode: .Vehicule, chosenTransportationType: .SmallDieselCar).environmentObject(CarbonFootprint())
    }
}
