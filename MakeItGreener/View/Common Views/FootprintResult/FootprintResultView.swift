//
//  Co2ResultView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI
import MapKit

struct FootprintResultView: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var isFromDatabase: Bool = false
    
    var body: some View {
        VStack() {
            TravelDetailPanel(footprintResult: footprintResult)
            Spacer()
            Co2ValueView(footprintResult: footprintResult)
            Spacer()
            if !isFromDatabase {
                SaveTravelView(footprintResult: footprintResult)
            }
            else {
                DismissButtonView()
            }
            Spacer()
        }
        .background(.linearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
        // Show an alert when saving to Core Data failed
        .alert(footprintResult.errorDescription, isPresented: $footprintResult.viewContextHasError, actions: {})
    }
}

struct FootprintResultView_Previews: PreviewProvider {
    static var previews: some View {
        FootprintResultView(footprintResult: FootprintResultObservableObject())
        
    }
}
