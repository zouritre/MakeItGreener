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
    @EnvironmentObject var travelSearchOO: TravelSearchObservableObject
    
    var body: some View {
        NavigationView {
                Form {
                    Section(content: {
                        TravelSideView(travelSide: .Start)
                            .accessibilityLabel("You start at \(travelSearchOO.departureLocation?.title ?? "Undefined")")
                        TravelSideView(travelSide: .Arrival)
                            .accessibilityLabel("You arrive at \(travelSearchOO.arrivalLocation?.title ?? "Undefined")")
                    }, header: {
                        Text("Locations")
                            .accessibilityAddTraits(.isHeader)
                    }, footer: {
                        Text("\(carbonFootprintOO.formattedTravelDistance)")
                            .accessibilityLabel("Distance between departure and arrival")
                            .accessibilityValue("\(carbonFootprintOO.formattedTravelDistance)")
                    })
                    .accessibilityRemoveTraits(.isImage)
                    
                    Section(content: {
                        TransportationModeView()
                        TransportationTypeView()
                            .accessibilityLabel("Your transportation type is")
                            .accessibilityValue(carbonFootprintOO.chosenTransportationType.userString())
                            .accessibilityHint("Tap to modify")
                    }, header: {
                        Text("Transportation")
                            .accessibilityLabel("Choose your transportation mode")
                            .accessibilityRemoveTraits(.isHeader)
                    })
                    Section {
                        Button("Save") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .accessibilityLabel("Save this travel settings")
                    }
                }
                .navigationTitle(travelSearchOO.travelSide == .Start ? "Where do you start ?" : "Where do you go ?")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        TravelLocationItem(travelSide: .Start)
                            .accessibilityLabel("Configure the departure location")
                            .accessibilityAddTraits(travelSearchOO.travelSide == .Start ? .isSelected : .isButton)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        TravelLocationItem(travelSide: .Arrival)
                            .accessibilityLabel("Configure the arrival location")
                            .accessibilityAddTraits(travelSearchOO.travelSide == .Arrival ? .isSelected : .isButton)
                    }
                }
        }
        .navigationViewStyle(.stack)
        //Always display search bar
        .searchable(text: $travelSearchOO.searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Enter a location") {
            if travelSearchOO.completerHasError {
                Text("No results found")
                    .accessibilityLabel("No result found")
                    .accessibilityHint("Enter an address or location")
            }
            else {
                ForEach(travelSearchOO.completerResults, id: \.self) { completion in
                    CompletionView(completionObject: completion)
                }
            }
        }
        .onSubmit(of: .search, {
            travelSearchOO.search(usingCompletion: false)
        })
    }
}

struct TravelForm_Previews: PreviewProvider {
    static var previews: some View {
        TravelForm()
            .environmentObject(CarbonFootprintObservableObject())
            .environmentObject(TravelSearchObservableObject())
    }
}
