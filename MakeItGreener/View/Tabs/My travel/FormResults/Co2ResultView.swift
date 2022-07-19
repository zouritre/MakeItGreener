//
//  co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct Co2ResultView: View {
    @EnvironmentObject var carbonFootprintOO: CarbonFootprintObservableObject
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .onAppear {
//            carbonFootprintOO.getFootprint()
        }
        .alert(carbonFootprintOO.errorDescription ?? "", isPresented: $carbonFootprintOO.requestError, actions: {
            //Disable activity indicator
            Text("Ok")
        })
    }
}

struct co2Result_Previews: PreviewProvider {
    static var previews: some View {
        Co2ResultView()
            .environmentObject(CarbonFootprintObservableObject())
    }
}
