//
//  SettingsOverlay.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 19/07/2022.
//

import SwiftUI

struct SettingsOverlay: View {
    var body: some View {
        Circle()
            .frame(width: 60, height: 60, alignment: .center)
            .foregroundColor(.gray)
            .overlay(alignment: .center) {
                Image(systemName: "gear")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .shadow(radius: 10)
            .accessibilityLabel("Settings")
            .accessibilityHint("Configure your travel")
    }
}

struct SettingsOverlay_Previews: PreviewProvider {
    static var previews: some View {
        SettingsOverlay()
    }
}
