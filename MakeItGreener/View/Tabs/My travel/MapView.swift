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
        .edgesIgnoringSafeArea([.bottom])
        .sheet(isPresented: $showSheet) {
            TravelForm()
        }
        .overlay(alignment: .bottomLeading) {
            Circle()
                .frame(width: 60, height: 60, alignment: .center)
                .foregroundColor(.secondary)
                .overlay(alignment: .center) {
                    Image(systemName: "gear")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                .offset(x: 20, y: -60)
                .onTapGesture {
                    showSheet.toggle()
                }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(travelSearchObservableObject())
    }
}
