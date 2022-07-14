//
//  MapView.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var locations: [MapLocation]
    
    //Apple Park location as default
    @State var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
          latitude: 37.334_900,
          longitude: -122.009_020
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.5,
          longitudeDelta: 0.5))
    @State var tracking: MapUserTrackingMode = .none
    
    var body: some View {
        Map(
           coordinateRegion: $region,
           showsUserLocation: true,
           userTrackingMode: $tracking,
           annotationItems: locations)
        { location in
            MapAnnotation(coordinate: location.location, content: {
                if location.name == .Start {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.red)
                        .imageScale(.large)
                    Text(location.name.rawValue)
                        .font(.system(size: 28, weight: .bold, design: .default))
                }
                else {
                    Image(systemName: "flag.circle.fill")
                        .foregroundColor(.red)
                        .imageScale(.large)
                    Text(location.name.rawValue)
                        .font(.system(size: 28, weight: .bold, design: .default))
                }
            })
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locations: .constant([
            MapLocation(lat: 37.334_900, long: -122.009_020, name: .Start),
            MapLocation(lat: 37.334_910, long: -121.91, name: .Arrival)]))
    }
}
