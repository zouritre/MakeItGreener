//
//  TravelLocationItem.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct TravelLocationItem: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject

    let travelSide: LocationLabel
    
    var body: some View {
        Button(action: {
            self.travelSearchOO.travelSide = self.travelSide
        }, label: {
            Label(self.travelSide == .Start ? "Departure" : "Arrival", systemImage: self.travelSide == .Start ? "figure.walk" : "flag.fill")
        })
        .foregroundColor(travelSearchOO.travelSide == self.travelSide ? .red : .blue)
    }
}

struct TravelLocationItem_Previews: PreviewProvider {
    static var previews: some View {
        TravelLocationItem(travelSide: .Start)
            .environmentObject(travelSearchObservableObject())
    }
}
