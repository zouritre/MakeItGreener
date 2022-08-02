//
//  TransportationModeView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 14/07/2022.
//

import SwiftUI

struct TransportationModeView: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
    var body: some View {
        Picker("How do you go?", selection: $carbonFootprintOO.chosenTransportationMode.animation()) {
            ForEach(carbonFootprintOO.transportationModes, id: \.self) {
                Text($0.userString())
                    .accessibilityLabel($0.userString())
            }
        }
        .pickerStyle(.segmented)
    }
}

struct TransportationModeView_Previews: PreviewProvider {
    static var previews: some View {
        TransportationModeView()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
