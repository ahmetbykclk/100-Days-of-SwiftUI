//
//  DividerView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 13.08.2025.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
            .accessibilityHidden(true)
    }
}

#Preview {
    VStack {
        Text("Above")
        DividerView()
        Text("Below")
    }
    .background(.darkBackground)
    .preferredColorScheme(.dark)
}
