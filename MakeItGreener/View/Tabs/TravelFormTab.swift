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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MapView()
                
                Form {
                    Section(content: {
                        TravelLocationView(travelSide: .Start)
                        TravelLocationView(travelSide: .Arrival)
                    }, header: {
                        Text("Distance")
                    }, footer: {
                        Text("\(carbonFootprintOO.travelDistance) km")
                    })
                    Section(content: {
                        TransportationModeView()
                        TransportationTypeView()
                    }, header: {
                        Text("Transportation")
                    })
                    Section {
                        NavigationLink( destination: { co2ResultView() }) {
                            TravelFormSubmit()
                        }
                    }
                }
                .navigationTitle(travelSearchOO.travelSide == .Start ? "Where do you start ?" : "Where do you go ?")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        TravelLocationItem(travelSide: .Start)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        TravelLocationItem(travelSide: .Arrival)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        //Always display search bar
        .searchable(text: $travelSearchOO.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a location") {
            if travelSearchOO.completerHasError {
                Text("No results found")
            }
            else {
                ForEach(travelSearchOO.completerResults, id: \.self) { completion in
                    CompletionView(completionObject: completion)
                }
            }
        }
        // Search button is pressed in search bar
        .onSubmit(of: .search, {
            travelSearchOO.search()
        })
    }
}

struct TravelFormTab_Previews: PreviewProvider {
    static var previews: some View {
        TravelFormTab()
            .environmentObject(CarbonFootprintObservableObject())
            .environmentObject(travelSearchObservableObject())
    }
}
