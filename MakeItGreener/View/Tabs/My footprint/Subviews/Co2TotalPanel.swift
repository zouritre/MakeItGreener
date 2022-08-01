//
//  Co2TotalPanel.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 01/08/2022.
//

import SwiftUI

struct Co2TotalPanel: View {
    @FetchRequest(
        sortDescriptors: [])
    private var items: FetchedResults<Travel>
    
    private var totalCo2: Double {
        var total: Double = 0
        
        items.forEach { travelData in
            total += travelData.footprint
        }
        
        return total
    }
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Unit measurement of CO2
    private var unit: String {
        let unit = totalCo2 >= 1000 ? "TCO2e" : "KgCO2e"
        
        return unit
    }
    
    /// Convert from Kg to tons if >= 1000kg
    private var formattedTotal: String {
        let formattedTotal = totalCo2 >= 1000 ? totalCo2/1000 : totalCo2
        
        return formatter.string(from: formattedTotal as NSNumber) ?? "Error"
    }
    
    var body: some View {
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
    }
}

struct Co2TotalPanel_Previews: PreviewProvider {
    static var previews: some View {
        Co2TotalPanel()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
