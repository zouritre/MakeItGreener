//
//  TravelLocationView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI
import MapKit

struct TravelLocationView: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    var locationData: MKLocalSearchCompletion? {
        travelSide == .Start ? travelSearchOO.departureLocation : travelSearchOO.arrivalLocation
    }
    
    let travelSide: LocationLabel
    
    var body: some View {
        HStack {
            Image(systemName: self.travelSide == .Start ? "figure.walk" : "flag.fill")
                .symbolRenderingMode(.palette)
                .foregroundColor(.red)
            VStack(alignment: .leading) {
                Text(self.locationData?.title ?? "")
                Text(self.locationData?.subtitle ?? "")
            }
            Spacer()
        }
    }
}

struct TravelLocationView_Previews: PreviewProvider {
    static var previews: some View {
        TravelLocationView(travelSide: .Start)
            .environmentObject(travelSearchObservableObject())
    }
}
