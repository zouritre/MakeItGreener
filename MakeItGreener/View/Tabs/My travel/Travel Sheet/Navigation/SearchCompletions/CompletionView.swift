//
//  completionView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 15/07/2022.
//

import SwiftUI
import MapKit

struct CompletionView: View {
    @Environment(\.dismissSearch) private var dismissSearch
    
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    /// Map locationt completion object
    let completionObject: MKLocalSearchCompletion
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(self.completionObject.title) {}
                .font(.title.weight(.bold))
            Button(self.completionObject.subtitle) {}
                .font(.body.weight(.light))
        }
        .foregroundColor(.primary)
        .onTapGesture {
            // Set the search bar text to the selected completion title
            travelSearchOO.searchTerm = self.completionObject.title
            // Store the selected completion
            if travelSearchOO.travelSide == .Start {
                travelSearchOO.departureLocation = completionObject
            }
            else {
                travelSearchOO.arrivalLocation = completionObject
            }
            // Dismiss the search bar focus
            dismissSearch()
            // Search the location of the selected text completion
            travelSearchOO.search(usingCompletion: true)
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView(completionObject: MKLocalSearchCompletion())
    }
}
