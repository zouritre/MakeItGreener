//
//  co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct co2ResultView: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
//    init() {
//        carbonFootprintOO.getFootprint()
//    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .alert(carbonFootprintOO.errorDescription, isPresented: $carbonFootprintOO.requestError, actions: {
                //Disable activity indicator
                //Re-enable button
                Text("I'll fix that")
            })
    }
}

struct co2Result_Previews: PreviewProvider {
    static var previews: some View {
        co2ResultView()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
