//
//  AnnotationDesign.swift
//  MakeItGreener
//
//  Created by Bertrand Dalleau on 16/07/2022.
//

import SwiftUI

struct AnnotationDesign: View {
    var body: some View {
        Image(systemName: "mappin.and.ellipse")
            .foregroundColor(.red)
            .font(.system(size: 60))
    }
}

struct AnnotationDesign_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationDesign()
    }
}
