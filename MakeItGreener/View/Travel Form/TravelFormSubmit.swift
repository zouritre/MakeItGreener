//
//  TravelFormSubmit.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct TravelFormSubmit: View {
    var body: some View {
        Button(action: {}, label: {
            Label("How green am I", systemImage: "leaf.circle.fill")
        })
        .symbolRenderingMode(.multicolor)
    }
}

struct TravelFormSubmit_Previews: PreviewProvider {
    static var previews: some View {
        TravelFormSubmit()
    }
}
