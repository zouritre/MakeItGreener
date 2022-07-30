//
//  TravelRow.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 30/07/2022.
//

import SwiftUI
import MapKit

struct TravelRow: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    @State private var showDetail = false
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(footprintResult.timestamp)
                Image(footprintResult.transportationMode.imageName())
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                Text("\(footprintResult.distance) km")
            }
            Spacer()
            VStack(alignment: .center) {
                Text("\(footprintResult.footprint)")
                Text("KgCO2e")
            }
        }
        .padding(6)
        .background(.green)
        .cornerRadius(15)
        .sheet(isPresented: $showDetail) {
            Co2ResultView(footprintResult: footprintResult, isFromDatabase: true)
        }
        .onTapGesture {
            showDetail.toggle()
        }
    }
}

struct TravelRow_Previews: PreviewProvider {
    static let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 3000, timestamp: .now)
    static var previews: some View {
        TravelRow(footprintResult: FootprintResultObservableObject(with: travelData))
    }
}
