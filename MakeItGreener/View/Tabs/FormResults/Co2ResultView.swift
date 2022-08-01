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
                ResultDetailPanel(footprintResult: footprintResult)
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
                    // Display the button if the view was shown after pressing "Get my footprint" button from My travel tab
                    Button("Save this travel"){
                        footprintResult.saveTravel(in: managedObjectContext)
                    }
                    .font(.system(size: 20).bold())
                    .buttonStyle(.borderedProminent)
                    .tint(Color.init(white: 0.2, opacity: 0.8))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 0)
                    .padding()
                }
                else {
                    // Display the button if the view was shown from My footprint tab sheet
                    Button("X") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: 20).bold())
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle()
                        .foregroundColor(Color.init(white: 0.2, opacity: 0.8))
                        .shadow(radius: 0))
                }
                Spacer()
            }
        }
        .background(.linearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
        // Show an alert when saving to Core Data failed
        .alert(footprintResult.errorDescription, isPresented: $footprintResult.viewContextHasError, actions: {})
    }
}

struct co2Result_Previews: PreviewProvider {
    
    static var previews: some View {
        Co2ResultView(footprintResult: FootprintResultObservableObject())
        
    }
}
