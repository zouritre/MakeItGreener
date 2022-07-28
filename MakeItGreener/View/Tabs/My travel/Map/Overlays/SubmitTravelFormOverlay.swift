//
//  SubmitTravelFormOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct SubmitTravelFormOverlay: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
    @State var missingTravelData = false
    
    var body: some View {
        VStack {
            NavigationLink(destination:
                            Co2ResultView(footprintResult: FootprintResultObservableObject(with: carbonFootprintOO.travelData ?? TravelData(distance: 0, transportationType: .SmallPetrolCar, transportationMode: .Vehicule))),
                           isActive: $carbonFootprintOO.hasFootprintResult) {}
            Button(action: {
                // Display alert if departure or arrival location is not set
                if travelSearchOO.mapAnnotations.count < 2 {
                    missingTravelData.toggle()
                }
                else {
                    // Otherwise request carbon footprint from API
//                    carbonFootprintOO.getFootprint()
                    carbonFootprintOO.footprintResult = 47.987
                    carbonFootprintOO.travelData = carbonFootprintOO.getCompleteTravelData()
                    carbonFootprintOO.hasFootprintResult = true
                }
            }, label: {
                if carbonFootprintOO.isLoading {
                    ProgressView()
                        .tint(.white)
                }
                else {
                    Label("Get my footprint", systemImage: "leaf.arrow.triangle.circlepath")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.white)
                }
            })
            .frame(width: 300, height: 50)
            .background(.gray)
            .buttonStyle(.bordered)
            .cornerRadius(15)
            .shadow(radius: 10)
            .alert("You must select a departure and arrival location", isPresented: $missingTravelData, actions: {})
            .alert(carbonFootprintOO.errorDescription ?? "Unknown error", isPresented: $carbonFootprintOO.requestError, actions: {})
        }
    }
}

struct SubmitTravelFormOverlay_Previews: PreviewProvider {
    static var previews: some View {
        SubmitTravelFormOverlay()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
