//
//  completionView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 15/07/2022.
//

import SwiftUI
import MapKit

struct CompletionView: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    let completionObject: MKLocalSearchCompletion
    
    private var index: Int {
        travelSearchOO.completerResults.firstIndex {
            $0 == completionObject
        } ?? 0
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.completionObject.title)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
                Text(self.completionObject.subtitle)
                    .font(.body.weight(.light))
                    .foregroundColor(.black)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .onTapGesture {
            travelSearchOO.searchTerm = self.completionObject.title
            travelSearchOO.setSelectedCompletion(for: completionObject)
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView(completionObject: MKLocalSearchCompletion())
    }
}
