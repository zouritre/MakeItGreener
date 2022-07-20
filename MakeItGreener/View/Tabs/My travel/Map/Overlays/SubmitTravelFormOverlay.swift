//
//  SubmitTravelFormOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct SubmitTravelFormOverlay: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    @State var presentAlert = false
    @State var presentResult = false

    var body: some View {
        VStack {
            NavigationLink(destination: Co2ResultView(), isActive: $presentResult) {}
            Button(action: {
                if travelSearchOO.mapAnnotations.count < 2 {
                    presentAlert.toggle()
                }
                else {
                    presentResult.toggle()
                }
            }, label: {
                Label("Get my footprint", systemImage: "leaf.arrow.triangle.circlepath")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
            })
            .background(.gray)
            .buttonStyle(.bordered)
            .cornerRadius(15)
            .shadow(radius: 10)
            .alert("You must select a departure and arrival location", isPresented: $presentAlert, actions: {})
        }
    }
}

struct SubmitTravelFormOverlay_Previews: PreviewProvider {
    static var previews: some View {
        SubmitTravelFormOverlay()
    }
}
