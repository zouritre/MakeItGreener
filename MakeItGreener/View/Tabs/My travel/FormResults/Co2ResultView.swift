//
//  Co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI
import MapKit

struct Co2ResultView: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var body: some View {
        Group{
            VStack(spacing: 20 ) {
                HStack {
                    VStack(alignment: .center) {
                        Text(footprintResult.transportationType.userString())
                        Image("car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                        Text("\(footprintResult.distance) km")
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .center) {
                        Text(footprintResult.departure.title)
                        Text(footprintResult.departure.subtitle)
                            .font(.subheadline)
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        Text(footprintResult.arrival.title)
                        Text(footprintResult.arrival.subtitle)
                            .font(.subheadline)
                    }
                    .padding()
                }
                .font(.headline.weight(.heavy))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .background(Color.init(white: 0.5, opacity: 0.5))
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 0)
                .frame(height: 150)
                .padding()
                ZStack (alignment: .center) {
                    Circle()
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Empreinte carbone\ndu trajet")
                            .multilineTextAlignment(.center)
                        Spacer()
                        Text("\(footprintResult.footprint)")
                        Text("KgCO2e")
                            .font(.headline)
                        Spacer()
                    }
                    .font(.title3.weight(.heavy))
                    .foregroundColor(.black)
                }
                .padding()
                Button("Save this travel"){}
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.init(white: 0.5, opacity: 0.5))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 0)
                    .padding()
            }
        }
        .background(.green)
    }
}

struct co2Result_Previews: PreviewProvider {
    static let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 50)
    
    static var previews: some View {
        Co2ResultView(footprintResult: FootprintResultObservableObject(with: travelData))
            .preferredColorScheme(.dark)
            
    }
}
