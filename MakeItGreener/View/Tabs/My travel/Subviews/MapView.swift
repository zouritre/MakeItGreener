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
    @State var showSheet = false
    
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
        .edgesIgnoringSafeArea([.bottom, .top])
        .sheet(isPresented: $showSheet) {
            TravelForm()
        }
        .overlay(alignment: .topTrailing) {
            VStack(alignment: .center) {
                DepartArrivalOverlay()
                SettingsOverlay()
                    .onTapGesture {
                        showSheet.toggle()
                    }
            }
            .offset(x: -10, y: 30)
        }
        .overlay(alignment: .bottom) {
            GetMyFootprintOverlay()
                .offset(x: 0, y: -60)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(travelSearchObservableObject())
            .environmentObject(CarbonFootprintObservableObject())
    }
}
