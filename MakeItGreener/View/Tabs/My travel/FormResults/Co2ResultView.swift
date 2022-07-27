//
//  Co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct Co2ResultView: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var body: some View {
        Text("Your footprint for this travel is: \(footprintResult.footprint)")
    }
}

struct co2Result_Previews: PreviewProvider {
    static let travelData = TravelData(arrival: "Paris", departure: "Lyon", distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 50)
    
    static var previews: some View {
        Co2ResultView(footprintResult: FootprintResultObservableObject(with: travelData))
    }
}
