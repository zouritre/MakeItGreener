//
//  Co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI
import MapKit

struct Co2ResultView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    var footprintResult: FootprintResultViewModel
    
    var isFromDatabase: Bool = false
    
    var body: some View {
        Group{
            VStack() {
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
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    Text("\(footprintResult.footprint)")
                    Text("KgCO2e")
                        .font(.headline)
                    Spacer()
                }
                .font(.system(size: 70).weight(.heavy))
                .foregroundColor(.white)
                Spacer()
                if !isFromDatabase {
                    // Display the button if the view was shown from My travel tab, and not from My footprint tab"
                    Button("Save this travel"){
                        footprintResult.saveTravel(in: managedObjectContext)
                    }
                    .font(.system(size: 40).bold())
                    .buttonStyle(.borderedProminent)
                    .tint(Color.init(white: 0.5, opacity: 0.5))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 0)
                    .padding()
                }
                else {
                    Button("X") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: 40).bold())
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle()
                        .foregroundColor(Color.init(white: 0.5, opacity: 0.5))
                        .shadow(radius: 0))
                }
                Spacer()
            }
        }
        .background(.radialGradient(.init(colors: footprintResult.footprintSeverityIndicator), center: UnitPoint.init(x: 0.5, y: 0.55), startRadius: footprintResult.gradientStartRadius, endRadius: footprintResult.gradientEndRadius))
    }
}

struct co2Result_Previews: PreviewProvider {
    
    static var previews: some View {
        Co2ResultView(footprintResult: FootprintResultViewModel())
        
    }
}
