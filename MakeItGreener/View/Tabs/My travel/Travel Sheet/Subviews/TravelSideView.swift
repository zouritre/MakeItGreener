//
//  TravelLocationView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI
import MapKit

struct TravelSideView: View {
    @EnvironmentObject var travelSearchOO: TravelSearchObservableObject
    
    // Completion object to be used for displaying travel location informations
    var locationData: MKLocalSearchCompletion? {
        travelSide == .Start ? travelSearchOO.departureLocation : travelSearchOO.arrivalLocation
    }
    
    /// Represent the arrival or departure location
    let travelSide: LocationLabel
    
    private var accessLabel: String {
        travelSide == .Start ? "You start at" : "You arrive at"
    }
    
    var body: some View {
        HStack {
            Image(systemName: self.travelSide == .Start ? "figure.walk" : "flag.fill")
                .symbolRenderingMode(.palette)
                .foregroundColor(.primary)
            VStack(alignment: .leading) {
                Text(self.locationData?.title ?? "")
                Text(self.locationData?.subtitle ?? "")
            }
            .accessibilityHidden(true)
            Spacer()
        }
    }
}

struct TravelSideView_Previews: PreviewProvider {
    static var previews: some View {
        TravelSideView(travelSide: .Start)
            .preferredColorScheme(.dark)
            .environmentObject(TravelSearchObservableObject())
    }
}
