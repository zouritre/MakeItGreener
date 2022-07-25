//
//  Co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct Co2ResultView: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
    var body: some View {
        Text("Your footprint for this travel is: \(carbonFootprintOO.formattedFootprintResult)")
        .onAppear {
            carbonFootprintOO.getFootprint()
        }
        .alert(carbonFootprintOO.errorDescription ?? "Unknown error", isPresented: $carbonFootprintOO.requestError, actions: {})
    }
}

struct co2Result_Previews: PreviewProvider {
    static var previews: some View {
        Co2ResultView()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
