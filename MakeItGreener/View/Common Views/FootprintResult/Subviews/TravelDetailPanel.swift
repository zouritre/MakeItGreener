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
                    .accessibilityLabel("Transportation type is")
                    .accessibilityValue("\(footprintResult.transportationType)")
                Image(footprintResult.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .accessibilityHidden(true)
                Text("\(footprintResult.distance) km")
                    .accessibilityLabel("Travel distance is")
                    .accessibilityValue("\(footprintResult.distance) km")
            }
            .padding()
            Spacer()
            VStack(alignment: .center) {
                Text(footprintResult.departureTitle)
                    .accessibilityLabel("Departure location is")
                    .accessibilityValue("\(footprintResult.departureTitle), \(footprintResult.departureSubtitle)")
                Text(footprintResult.departureSubtitle)
                    .font(.subheadline)
                    .accessibilityHidden(true)
                Image("arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .accessibilityHidden(true)
                Text(footprintResult.arrivalTitle)
                    .accessibilityLabel("Arrival location is")
                    .accessibilityValue("\(footprintResult.arrivalTitle), \(footprintResult.arrivalSubtitle)")
                Text(footprintResult.arrivalSubtitle)
                    .font(.subheadline)
                    .accessibilityHidden(true)
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
