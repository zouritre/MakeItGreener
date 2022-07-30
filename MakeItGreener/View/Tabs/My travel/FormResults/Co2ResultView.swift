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
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var isFromDatabase: Bool = false
    
    var body: some View {
        Group{
            VStack() {
                HStack {
                    VStack(alignment: .center) {
                        Text(footprintResult.transportationType.userString())
                        Image(footprintResult.transportationMode.imageName())
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
                        saveTravel()
                    }
                        .font(.headline)
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
                        .font(.headline)
                        .buttonStyle(.borderedProminent)
                        .tint(Color.init(white: 0.5, opacity: 0.5))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .shadow(radius: 0)
                        .padding()
                }
            }
        }
        .background(.radialGradient(.init(colors: footprintResult.footprintSeverityIndicator), center: UnitPoint.init(x: 0.5, y: 0.55), startRadius: footprintResult.gradientStartRadius, endRadius: footprintResult.gradientEndRadius))
    }
    
    private func saveTravel() {
        withAnimation {
            let newTravel = Travel(context: managedObjectContext)
            newTravel.data = footprintResult.travelData

            do {
                try managedObjectContext.save()
            } catch {
                print("Save failed")
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct co2Result_Previews: PreviewProvider {
    static let travelData = TravelData(arrival: MKLocalSearchCompletion(), departure: MKLocalSearchCompletion(), distance: 492, transportationType: .SmallPetrolCar, transportationMode: .Vehicule, footprint: 3000)
    
    static var previews: some View {
        Co2ResultView(footprintResult: FootprintResultObservableObject(with: travelData))
            
    }
}
