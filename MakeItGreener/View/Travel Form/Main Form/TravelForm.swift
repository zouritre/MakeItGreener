//
//  TravelForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TravelForm: View {
    @EnvironmentObject var carbonFootprint: CarbonFootprint
    
    @State private var locations = [MapLocation]()
    @State var chosenTransportationMode: TransportationMode = .Vehicule
    @State var chosenTransportationType: TransportationType = .MediumDieselCar
    
    var distance: Float {
        return 1000
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MapView(locations: $locations)
                
                Form {
                    Section(content: {
                        DistanceForm(locations: $locations)
                    }, header: {
                        Text("Distance")
                        
                    }, footer: {
                        Text(String(distance))
                        
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
                    }
                }
                
                
            }
            NavigationLink(isActive: $carbonFootprint.footprintAvailable, destination: { EmptyView() }, label: { Text("ResultView")})
        }
        .navigationViewStyle(.stack)
        .alert(self.carbonFootprint.errorDescription, isPresented: $carbonFootprint.errorFound, actions: {
            //Disable activity indicator
            //Re-enable button
            return Text("I'll fix that")
        })
    }
}

struct TravelForm_Previews: PreviewProvider {
    static var previews: some View {
        TravelForm(chosenTransportationMode: .Vehicule, chosenTransportationType: .MediumDieselCar).environmentObject(CarbonFootprint())
    }
}
