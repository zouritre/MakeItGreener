//
//  SaveTravelView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 01/08/2022.
//

import SwiftUI

struct SaveTravelView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var footprintResult: FootprintResultObservableObject
    
    var body: some View {
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
}

struct SaveTravelView_Previews: PreviewProvider {
    static var previews: some View {
        SaveTravelView(footprintResult: FootprintResultObservableObject())
    }
}
