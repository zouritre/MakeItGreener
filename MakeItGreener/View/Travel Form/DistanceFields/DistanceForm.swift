//
//  DistanceForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 13/07/2022.
//

import SwiftUI

struct DistanceForm: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    var body: some View {
        List {
            TravelLocationView(locationData: travelSearchOO.departureLocation, imageName: "figure.walk")
            TravelLocationView(locationData: travelSearchOO.arrivalLocation, imageName: "flag.fill")
        }
        .listStyle(.automatic)
    }
}

struct DistanceForm_Previews: PreviewProvider {
    static var previews: some View {
        DistanceForm()
            .environmentObject(travelSearchObservableObject())
    }
}
