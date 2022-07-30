//
//  MyFootprint.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 12/07/2022.
//

import SwiftUI

struct MyFootprintTab: View {
    @FetchRequest(
        sortDescriptors: [])
    private var items: FetchedResults<Travel>
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 50) {
                    Spacer()
                    Text("Mon empreinte\ncarbone annuel")
                        .multilineTextAlignment(.center)
                    Text("50")
                    Text("KgCO2e")
                        .font(.headline)
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .background(Circle()
                    .foregroundColor(.white))
            }
            List {
                ForEach(items) { item in
                    Text("\(item.data?.distance ?? 0)")
                }
            }
            .cornerRadius(20)
            .padding()
        }
        .background(.green)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        MyFootprintTab()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
