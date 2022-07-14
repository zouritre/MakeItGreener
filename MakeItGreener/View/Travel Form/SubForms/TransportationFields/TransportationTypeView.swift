//
//  TransportationForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TransportationTypeView: View {
    @EnvironmentObject var carbonFootprintObsObj: CarbonFootprint
    
    var transportationTypeTitle: String {
        return carbonFootprintObsObj.chosenTransportationMode.description()
    }
    
    var body: some View {
        Picker(transportationTypeTitle, selection: $carbonFootprintObsObj.chosenTransportationType) {
            ForEach(carbonFootprintObsObj.transportationTypes, id: \.self) {
                Text($0.userString())
            }
        }
    }
}

struct TransportationType_Previews: PreviewProvider {
    static var previews: some View {
        TransportationTypeView()
            .environmentObject(CarbonFootprint())
    }
}
