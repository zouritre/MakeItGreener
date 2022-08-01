//
//  ResultDetailPanel.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 31/07/2022.
//

import SwiftUI

struct TravelDetailPanel: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(footprintResult.transportationType)
                Image(footprintResult.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                Text("\(footprintResult.distance) km")
            }
            .padding()
            Spacer()
            VStack(alignment: .center) {
                Text(footprintResult.departureTitle)
                Text(footprintResult.departureSubtitle)
                    .font(.subheadline)
                Image("arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(footprintResult.arrivalTitle)
                Text(footprintResult.arrivalSubtitle)
                    .font(.subheadline)
            }
            .padding()
        }
        .font(.headline.weight(.heavy))
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.6)
        .background(Color.init(white: 0.5, opacity: 0.5))
        .foregroundColor(.white)
        .cornerRadius(20)
        .shadow(radius: 0)
        .frame(height: 150)
        .padding()
    }
}

struct TravelDetailPanel_Previews: PreviewProvider {
    static var previews: some View {
        TravelDetailPanel(footprintResult: FootprintResultObservableObject())
    }
}
