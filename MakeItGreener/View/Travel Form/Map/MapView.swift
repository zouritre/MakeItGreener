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
                AnnotationDesign()
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
