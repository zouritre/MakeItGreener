//
//  TransportationModeView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 14/07/2022.
//

import SwiftUI

struct TransportationModeView: View {
    @EnvironmentObject var carbonFootprint: CarbonFootprint
    
    var body: some View {
        Picker("How do you go?", selection: $carbonFootprint.chosenTransportationMode.animation()) {
            ForEach(carbonFootprint.transportationModes, id: \.self) {
                Text($0.userString())
            }
        }
        .pickerStyle(.segmented)
    }
}

struct TransportationModeView_Previews: PreviewProvider {
    static var previews: some View {
        TransportationModeView()
            .environmentObject(CarbonFootprint())
    }
}
