//
//  MapView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var travelSearchOO: travelSearchObservableObject
    
    @State var tracking: MapUserTrackingMode = .none
    
    var body: some View {
        Map(
            coordinateRegion: $travelSearchOO.region,
            showsUserLocation: true,
            userTrackingMode: $tracking,
            annotationItems: travelSearchOO.mapAnnotations)
        { annotation in
            MapAnnotation(coordinate: annotation.location, content: {
                if annotation.name == .Start {
                    Text(annotation.name.rawValue)
                        .font(.title.weight(.bold))
                    Image(systemName: "figure.walk")
                        .foregroundColor(.red)
                        .imageScale(.large)
                }
                else {
                    Text(annotation.name.rawValue)
                        .font(.title.weight(.bold))
                    Image(systemName: "flag.circle.fill")
                        .foregroundColor(.red)
                        .imageScale(.large)
                }
            })
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(travelSearchObservableObject())
    }
}
