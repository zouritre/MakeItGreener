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
                SubmitTravelFormOverlay()
                    .offset(x: 0, y: -60)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.5)
                .frame(height: 80, alignment: .center)
                .edgesIgnoringSafeArea(.bottom)
                .offset(x: 0, y: 80)
                .blur(radius: 3)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .preferredColorScheme(.dark)
            .environmentObject(travelSearchObservableObject())
    }
}
