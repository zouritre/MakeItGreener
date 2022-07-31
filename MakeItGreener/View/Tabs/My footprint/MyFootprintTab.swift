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
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    private var unit: String {
        let unit = totalCo2 >= 1000 ? "TCO2e" : "KgCO2e"
    
        return unit
    }
    
    private var totalCo2: Double {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        var total: Double = 0
        
        items.forEach { travelData in
            total += travelData.footprint
        }
        
        return total
    }
    
    /// Convert from Kg to tons if >= 1000kg
    private var formattedTotal: String {
        let formattedTotal = totalCo2 >= 1000 ? totalCo2/1000 : totalCo2
        
        return formatter.string(from: formattedTotal as NSNumber) ?? "Error"
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .center, spacing: 20) {
                    Text("My annual carbon footprint")
                        .multilineTextAlignment(.center)
                        .padding()
                    VStack(alignment: .center) {
                        Text(formattedTotal)
                        Text(unit)
                            .font(.system(size: 30).bold())
                    }
                    .font(.system(size: 100, weight: .heavy, design: .rounded))
                    .padding()
                }
                .padding([.leading, .trailing], 20)
                .font(.system(size: 30).weight(.heavy))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .background(Rectangle()
                    .foregroundColor(Color.init(white: 0.3, opacity: 0.7))
                    .cornerRadius(20)
                    .shadow(radius: 0))
                .padding()
                ScrollView {
                    LazyVStack {
                        ForEach(items) { item in
                            TravelRow(footprintResult: FootprintResultViewModel(with: item))
                                .shadow(color: .white, radius: 5)
                                .padding(3)
                        }
                    }
                }
                .frame(height: 400, alignment: .center)
                .cornerRadius(20)
                .padding()
            }
//            .ignoresSafeArea()
            .background(Image("greenland"))
        }
        .navigationViewStyle(.stack)
        .navigationTitle("Test")
        .navigationBarHidden(true)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        MyFootprintTab()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
