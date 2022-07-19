//
//  SubmitTravelFormOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct SubmitTravelFormOverlay: View {
    @State var navigate = false
    var body: some View {
        Button(action: {
            navigate = true
        }, label: {
            Label("Get my footprint", systemImage: "leaf.arrow.triangle.circlepath")
                .font(.title.weight(.semibold))
                .foregroundColor(.white)
        })
        .background(.gray)
        .buttonStyle(.bordered)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct SubmitTravelFormOverlay_Previews: PreviewProvider {
    static var previews: some View {
        SubmitTravelFormOverlay()
    }
}
