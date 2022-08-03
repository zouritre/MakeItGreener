//
//  TravelRow.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 30/07/2022.
//

import SwiftUI
import MapKit

struct TravelRow: View {
    @State private var showDetail = false
    
    let footprintResult: FootprintResultObservableObject
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(footprintResult.timestamp)")
                Image("\(footprintResult.imageName)")
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
        .font(.system(.headline))
        .foregroundColor(.white)
        .padding()
        .background(.linearGradient(colors: [.green, .blue], startPoint: .leading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .sheet(isPresented: $showDetail) {
            FootprintResultView(footprintResult: footprintResult, isFromDatabase: true)
        }
        .onTapGesture {
            showDetail.toggle()
        }
        .accessibilityChildren {
            Text("Saved travel")
                .accessibilityAddTraits(.isHeader)
            Rectangle()
                .accessibilityLabel("\(footprintResult.timestamp), using \(footprintResult.imageName) for \(footprintResult.distance) km and \(footprintResult.footprint) kg of CO2 emitted")
                .accessibilityHint("Tap to see details")
        }
    }
}

struct TravelRow_Previews: PreviewProvider {
    static var previews: some View {
        TravelRow(footprintResult: FootprintResultObservableObject())
    }
}
