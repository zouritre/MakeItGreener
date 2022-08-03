//
//  DepartArrivalOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 18/07/2022.
//

import SwiftUI
import Mixpanel

struct DepartArrivalOverlay: View {
    @EnvironmentObject var travelSearchOO: TravelSearchObservableObject
    
    var departureImage: Image {
        if #available(iOS 15.0.0, *) {
            return Image(systemName: "airplane.departure")
        }
        else {
            return Image("departure")
        }
    }
    
    var arrivalImage: Image {
        if #available(iOS 15.0.0, *) {
            return Image(systemName: "airplane.arrival")
        }
        else {
            return Image("arrival")
        }
    }
    var body: some View {
        VStack {
            arrivalImage
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding()
                .onTapGesture {
                    travelSearchOO.travelSide = .Arrival
                    sendUsageData(side: .Arrival)
                }
            departureImage
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .padding()
                .onTapGesture {
                    travelSearchOO.travelSide = .Start
                    sendUsageData(side: .Start)
                }
        }
        .background(Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

/// Send the travel locations for analitycs
/// - Parameter side: Departure or arrival
private func sendUsageData(side: LocationLabel) {
    Mixpanel.mainInstance().track(event: "Dep/Arr Overlay Tapped", properties: [
        "Travel Side": "\(side.rawValue)"
    ])
}

struct DepartArrivalOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DepartArrivalOverlay()
            .environmentObject(TravelSearchObservableObject())
        
    }
}
