//
//  TransportationForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TransportationTypeView: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
    var transportationTypeTitle: String {
        return carbonFootprintOO.chosenTransportationMode.description()
    }
    
    var body: some View {
        Picker(transportationTypeTitle, selection: $carbonFootprintOO.chosenTransportationType) {
            ForEach(carbonFootprintOO.transportationTypes, id: \.self) {
                Text($0.userString())
                    .accessibilityLabel($0.userString())
            }
        }
    }
}

struct TransportationType_Previews: PreviewProvider {
    static var previews: some View {
        TransportationTypeView()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
