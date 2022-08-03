//
//  DismissButtonView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 01/08/2022.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button("X") {
            presentationMode.wrappedValue.dismiss()
        }
        .accessibilityLabel("Close")
        .accessibilityHint("Tap to go back")
        .font(.system(size: 20).bold())
        .buttonStyle(.plain)
        .foregroundColor(.white)
        .padding()
        .background(Circle()
            .foregroundColor(Color.init(white: 0.2, opacity: 0.8))
            .shadow(radius: 0))
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
