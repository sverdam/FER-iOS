//
//  FerHeader.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

import SwiftUI

struct FerHeader: View {
    var body: some View {
        Image("fer")
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(AppTheme.accentBlue.ignoresSafeArea(edges: .top))
    }
}

#Preview {
    FerHeader()
}
