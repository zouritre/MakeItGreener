//
//  DepartArrivalOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 18/07/2022.
//

import SwiftUI

struct DepartArrivalOverlay: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    var body: some View {
        if #available(iOS 15.0.0, *) {
            VStack {
                Image(systemName: "airplane.departure")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
                    .onTapGesture {
                        travelSearchOO.travelSide = .Start
                    }
                Image(systemName: "airplane.arrival")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding()
                    .onTapGesture {
                        travelSearchOO.travelSide = .Arrival
                    }
            }
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        } else {
            VStack {
                Image("departure-64")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .onTapGesture {
                        travelSearchOO.travelSide = .Start
                    }
                Image("arrival-64")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .onTapGesture {
                        travelSearchOO.travelSide = .Arrival
                    }
            }
            .background(.white)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct DepartArrivalOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DepartArrivalOverlay()
            
    }
}
