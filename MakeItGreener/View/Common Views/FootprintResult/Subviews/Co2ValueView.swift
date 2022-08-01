//
//  Co2ValueView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 01/08/2022.
//

import SwiftUI

struct Co2ValueView: View {
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("\(footprintResult.footprint)")
            Text("KgCO2e")
                .font(.headline)
            Spacer()
        }
        .font(.system(size: 70).weight(.heavy))
        .foregroundColor(.white)
    }
}

struct Co2ValueView_Previews: PreviewProvider {
    static var previews: some View {
        Co2ValueView(footprintResult: FootprintResultObservableObject())
            .preferredColorScheme(.dark)
    }
}
