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
            Co2ResultView(footprintResult: footprintResult, isFromDatabase: true)
        }
        .onTapGesture {
            showDetail.toggle()
        }
    }
}

struct TravelRow_Previews: PreviewProvider {
    static var previews: some View {
        TravelRow(footprintResult: FootprintResultObservableObject())
    }
}
