//
//  TravelForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TravelForm: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    /// Travel distance formatted to the user local
    var formattedDistance: String {
        let unit = travelSearchOO.travelDistance >= 1000 ? "km" : "m"
        
        // Format any number to max 2 decimals in user local
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        let distance = unit == "m" ? travelSearchOO.travelDistance : (travelSearchOO.travelDistance/1000)
        
        let formattedString = formatter.string(from: distance as NSNumber)
        
        return "\(formattedString ?? "0") \(unit)"
    }
    var body: some View {
        NavigationView {
                Form {
                    Section(content: {
                        TravelLocationView(travelSide: .Start)
                        TravelLocationView(travelSide: .Arrival)
                    }, header: {
                        Text("Distance")
                    }, footer: {
                        Text("\(formattedDistance)")
                    })
                    Section(content: {
                        TransportationModeView()
                        TransportationTypeView()
                    }, header: {
                        Text("Transportation")
                    })
                    Section {
                        Button("Save") {
                            presentationMode.wrappedValue.dismiss()
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
            travelSearchOO.search(usingCompletion: false)
        })
    }
}

struct TravelForm_Previews: PreviewProvider {
    static var previews: some View {
        TravelForm()
            .environmentObject(CarbonFootprintObservableObject())
            .environmentObject(travelSearchObservableObject())
    }
}
