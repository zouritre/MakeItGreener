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
    
    var navigationTitle: String {
        travelSearchOO.travelSide == .Start ? "Where do you start ?" : "Where do you go ?"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MapView()
                
                Form {
                    Section(content: {
                        DistanceForm()
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
//                        NavigationLink( destination: {EmptyView()}) {
                            Button(action: {
                                carbonFootprintOO.getFootprint()
                                //Disable button
                                //Enable activity indicator
                            }, label: {
                                Label("How green am I", systemImage: "leaf.circle.fill")
                            })
                            .symbolRenderingMode(.multicolor)
//                        }
                        
                        .alert(carbonFootprintOO.errorDescription, isPresented: $carbonFootprintOO.requestError, actions: {
                            //Disable activity indicator
                            //Re-enable button
                            Text("I'll fix that")
                        })
                    }
                }
                .navigationTitle(self.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.travelSearchOO.travelSide = .Start
                        }, label: {
                            Label("Start", systemImage: "figure.walk")
                        })
                        .foregroundColor(travelSearchOO.travelSide == .Start ? .red : .blue)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.travelSearchOO.travelSide = .Arrival
                        }, label: {
                            Label("Destination", systemImage: "flag.fill")
                        })
                        .foregroundColor(travelSearchOO.travelSide == .Arrival ? .red : .blue)
                    }
                }
            }
        }
        //Always display search bar
        .searchable(text: $travelSearchOO.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a location") {
            if travelSearchOO.completerIsEmpty {
                Text("No results found")
            }
            else {
                ForEach(travelSearchOO.completerResults, id: \.self) { completion in
                    CompletionView(completionObject: completion)
                }
            }
        }
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
