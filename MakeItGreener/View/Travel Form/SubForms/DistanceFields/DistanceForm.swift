//
//  DistanceForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 13/07/2022.
//

import SwiftUI

struct DistanceForm: View {
    @Binding var locations: [MapLocation]
    
    var body: some View {
        List {
            Text("Departure")
            Text("Arrival")
        }
    }
}

struct DistanceForm_Previews: PreviewProvider {
    static var previews: some View {
        DistanceForm(locations: .constant([
            MapLocation(lat: 37.334_900, long: -122.009_020, name: .Start),
            MapLocation(lat: 37.334_910, long: -121.9, name: .Arrival)]))
    }
}
