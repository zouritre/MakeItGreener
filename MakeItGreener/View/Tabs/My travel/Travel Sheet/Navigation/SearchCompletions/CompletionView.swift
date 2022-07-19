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
    
    let completionObject: MKLocalSearchCompletion
    
    private var index: Int {
        travelSearchOO.completerResults.firstIndex {
            $0 == completionObject
        } ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(self.completionObject.title) {}
                .font(.title.weight(.bold))
            Button(self.completionObject.subtitle) {}
                .font(.body.weight(.light))
        }
        .foregroundColor(.black)
        .onTapGesture {
            // Set the search bar title
            travelSearchOO.searchTerm = self.completionObject.title
            // Store the selected completion
            travelSearchOO.selectedCompletion[travelSearchOO.travelSide] = completionObject
            // Dismiss the search bar focus
            dismissSearch()
            // Search the location of the selected text completion
            travelSearchOO.search()
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView(completionObject: MKLocalSearchCompletion())
    }
}
