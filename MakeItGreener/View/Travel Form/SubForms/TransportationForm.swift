//
//  TransportationForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct TransportationForm: View {
    @Binding var chosenTransportationMode: TransportationMode
    @Binding var chosenTransportationType: TransportationType
    
    var transportationTypeTitle: String {
        return chosenTransportationMode.description()
    }
    var transportationModes = TransportationMode.allCases
    var transportationTypes: [TransportationType] {
        let filteredList = TransportationType.allCases.filter {
            guard let transportationId = $0.rawValue.first else {
                return false
            }
            
            return String(transportationId) == chosenTransportationMode.rawValue
        }
        
        return filteredList
    }
    
    var body: some View {
        Picker("How do you go?", selection: $chosenTransportationMode.animation()) {
            ForEach(transportationModes, id: \.self) {
                Text($0.userString())
            }
        }
        .pickerStyle(.segmented)
        
        Picker(transportationTypeTitle, selection: $chosenTransportationType) {
            ForEach(transportationTypes, id: \.self) {
                Text($0.userString())
            }
        }
    }
}

struct TransportationForm_Previews: PreviewProvider {
    static var previews: some View {
        TransportationForm(chosenTransportationMode: .constant(.Vehicule), chosenTransportationType: .constant(.MediumDieselCar))
    }
}
