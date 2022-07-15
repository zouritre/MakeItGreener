//
//  DistanceForm.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 13/07/2022.
//

import SwiftUI

struct DistanceForm: View {
    
    var body: some View {
        List {
            Text("Departure")
            Text("Arrival")
        }
    }
}

struct DistanceForm_Previews: PreviewProvider {
    static var previews: some View {
        DistanceForm()
    }
}
